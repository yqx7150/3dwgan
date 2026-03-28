#意思是prediction一张图
sigma = 8
radius = 2
n = 5
import torch
import torch.nn as nn
import numpy as np
import scipy.io

import os
os.environ['KMP_DUPLICATE_LIB_OK'] = 'True'
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader, random_split
import scipy.io
import numpy as np
import torch.nn.functional as F
import time
from tqdm import tqdm
import random
import os
import matplotlib.pyplot as plt
# 定义与训练时相同的 Generator3D 模型
class Generator3D(nn.Module):
    def __init__(self):
        super(Generator3D, self).__init__()
        self.encoder = nn.Sequential(
            nn.Conv3d(1, 32, kernel_size=3, padding=1), nn.ReLU(),
            nn.Conv3d(32, 64, kernel_size=3, stride=2, padding=1), nn.ReLU(),
            nn.Conv3d(64, 128, kernel_size=3, stride=2, padding=1), nn.ReLU(),
            nn.Conv3d(128, 256, kernel_size=3, padding=1), nn.ReLU()
        )
        self.decoder = nn.Sequential(
            nn.ConvTranspose3d(512, 256, kernel_size=3, padding=1), nn.ReLU(),
            nn.ConvTranspose3d(256, 128, kernel_size=3, stride=2, padding=1, output_padding=1), nn.ReLU(),
            nn.ConvTranspose3d(128, 64, kernel_size=3, stride=2, padding=1, output_padding=1), nn.ReLU(),
            nn.Conv3d(64, 1, kernel_size=3, padding=1)
            # 移除了 Sigmoid 激活函数
        )

    def forward(self, img1, img2):
        feat1 = self.encoder(img1)
        feat2 = self.encoder(img2)
        combined_feat = torch.cat((feat1, feat2), dim=1)
        output = self.decoder(combined_feat)
        target_shape = img1.shape[2:]
        output = F.interpolate(output, size=target_shape, mode='trilinear', align_corners=False)
        return output

def gaussian_function_3d(x, y, z, sigma):
    return np.exp(-(x ** 2 + y ** 2 + z ** 2) / (2 * sigma ** 2))


# filtering
# 产生高斯核
def generate_gaussian_kernel(radius, sigma):
    kernel = np.zeros(shape=(2 * radius + 1, 2 * radius + 1, 2 * radius + 1), dtype=float)
    normalization_factor = 0

    for i in range((-1) * radius, radius + 1):
        for j in range((-1) * radius, radius + 1):
            for k in range((-1) * radius, radius + 1):
                kernel[radius + i, radius + j, radius + k] = gaussian_function_3d(i, j, k, sigma)
                normalization_factor += kernel[radius + i, radius + j, radius + k]

    return kernel / normalization_factor

# 高斯滤波
def gaussian_smoothing(decision_map, kernel, radius):
    # 确保 decision_map 是在 CPU 上的 numpy 数组
    if isinstance(decision_map, torch.Tensor):
        decision_map = decision_map.cpu().numpy()

    z_points, x_points, y_points = decision_map.shape
    smoothed_decision_map = np.zeros(shape=(z_points, x_points, y_points), dtype=float)
    kernel_size = kernel.shape

    for z in range(n, z_points - n):
        for x in range(n, x_points - n):
            for y in range(n, y_points - n):
                smoothed_decision_map[z, x, y] = np.sum(np.multiply(kernel, decision_map[z - radius: z + radius + 1,
                                                                            x - radius: x + radius + 1,
                                                                            y - radius: y + radius + 1]))
    return smoothed_decision_map



def weighted_fusion(focus_A, focus_B, decision_map):
    z_points, x_points, y_points = decision_map.shape
    fusion = np.zeros(shape=(z_points, x_points, y_points), dtype=float)

    fusion = decision_map * focus_A + (1 - decision_map) * focus_B
    return fusion

# 体素信息融合
def volumetric_information_fusion(focus_A, focus_B, sigma, readius, map_initial):
    kernel = generate_gaussian_kernel(radius, sigma)
    final_decision_map = gaussian_smoothing(map_initial, kernel, radius)
    # fuse the multi-focus microscopy data
    fusion = weighted_fusion(focus_A, focus_B, final_decision_map)
    return fusion

# 加载预训练的模型权重
model_path = "D:\MFIF\generator_epoch_49.pth"
generator = Generator3D()
generator.load_state_dict(torch.load(model_path,weights_only=True))
generator.eval()

img1_path="D:\data15_PA_z35_SNR0_0_1_pad.mat"
img2_path="D:\data15_PA_z60_SNR0_0_1_pad.mat"
# 准备输入数据
img1 = scipy.io.loadmat(img1_path)['data_PA_z35_SNR0_0_1_pad']
img2 = scipy.io.loadmat(img2_path)['data_PA_z65_SNR0_0_1_pad']

img1 = torch.tensor(img1, dtype=torch.float32).unsqueeze(0).unsqueeze(0)  # 形状 [1, 1, depth, height, width]
img2 = torch.tensor(img2, dtype=torch.float32).unsqueeze(0).unsqueeze(0)


# 如果使用 GPU
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
generator.to(device)
img1, img2 = img1.to(device), img2.to(device)


# 进行预测
with torch.no_grad():
    output = generator(img1, img2)
# 在调用 gaussian_smoothing 之前，将 output 转换为 3D
output_3d = output.squeeze(0).squeeze(0)  # 压缩批次维度和通道维度，变为 [depth, height, width]
# 进行二值化操作，保持三维形式
output_3d_binary = (output_3d >= 0.5).float()  # 大于等于0.5的置1，小于0.5的置0

# 传递给 volumetric_information_fusion

# 准备输入数据
focus_A = scipy.io.loadmat(img1_path)['dataxianwei_PA_z35_SNR0_0_1_pad']
focus_B = scipy.io.loadmat(img2_path)['dataxianwei_PA_z65_SNR0_0_1_pad']
fusion = volumetric_information_fusion(focus_A, focus_B, sigma, radius, output_3d_binary)
fusion_results = {}
fusion_results['dataxianwei_SNR0_fusion_pad'] = fusion
scipy.io.savemat('G:\\3DGAN\\model_output\\fusion\\dataxianwei_SNR0_fusion_pad.mat', fusion_results)