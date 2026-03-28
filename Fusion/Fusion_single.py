# 单张图片融合（无权重版本）
sigma = 8
radius = 2
n = 5

import os
import numpy as np
import scipy.io
import matplotlib.pyplot as plt


def gaussian_function_3d(x, y, z, sigma):
    return np.exp(-(x ** 2 + y ** 2 + z ** 2) / (2 * sigma ** 2))


def generate_gaussian_kernel(radius, sigma):
    kernel = np.zeros(shape=(2 * radius + 1, 2 * radius + 1, 2 * radius + 1), dtype=float)
    normalization_factor = 0

    for i in range((-1) * radius, radius + 1):
        for j in range((-1) * radius, radius + 1):
            for k in range((-1) * radius, radius + 1):
                kernel[radius + i, radius + j, radius + k] = gaussian_function_3d(i, j, k, sigma)
                normalization_factor += kernel[radius + i, radius + j, radius + k]

    return kernel / normalization_factor


def gaussian_smoothing(decision_map, kernel, radius):
    z_points, x_points, y_points = decision_map.shape
    smoothed_decision_map = np.zeros(shape=(z_points, x_points, y_points), dtype=float)

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


def volumetric_information_fusion(focus_A, focus_B, sigma, radius, map_initial):
    kernel = generate_gaussian_kernel(radius, sigma)
    final_decision_map = gaussian_smoothing(map_initial, kernel, radius)
    fusion = weighted_fusion(focus_A, focus_B, final_decision_map)
    return fusion


if __name__ == '__main__':
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    
    z35_path = os.path.join(BASE_DIR, 'Data', 'wusi0123a.mat')
    z60_path = os.path.join(BASE_DIR, 'Data', 'wusi0123b.mat')
    
    print("加载焦点数据...")
    data_z35 = scipy.io.loadmat(z35_path)
    data_z60 = scipy.io.loadmat(z60_path)
    
    focus_A = data_z35[list(data_z35.keys())[-1]]
    focus_B = data_z60[list(data_z60.keys())[-1]]
    
    print("focus_A shape: {}".format(focus_A.shape))
    print("focus_B shape: {}".format(focus_B.shape))
    
    decision_map = np.ones(focus_A.shape, dtype=np.float32) * 0.5
    
    print("开始融合...")
    fusion = volumetric_information_fusion(focus_A, focus_B, sigma, radius, decision_map)
    
    print("融合结果 shape: {}, range: [{:.4f}, {:.4f}]".format(fusion.shape, fusion.min(), fusion.max()))
    
    output_dir = os.path.join(BASE_DIR, 'Data')
    os.makedirs(output_dir, exist_ok=True)
    fusion_results = {'wusi0123_fusion': fusion}
    output_path = os.path.join(output_dir, 'wusi0123_fusion.mat')
    scipy.io.savemat(output_path, fusion_results)
    print("融合结果已保存: {}".format(output_path))
    
    max_proj_z35 = np.max(focus_A, axis=0)
    max_proj_z60 = np.max(focus_B, axis=0)
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    im1 = ax1.imshow(max_proj_z35, cmap='hot')
    ax1.set_title('Focus Z=35 (Before Fusion)')
    ax1.axis('off')
    plt.colorbar(im1, ax=ax1, label='Intensity')
    
    im2 = ax2.imshow(max_proj_z60, cmap='hot')
    ax2.set_title('Focus Z=60 (Before Fusion)')
    ax2.axis('off')
    plt.colorbar(im2, ax=ax2, label='Intensity')
    
    plt.tight_layout()
    before_path = os.path.join(BASE_DIR, 'before_fusion_maxproj.png')
    plt.savefig(before_path, dpi=300, bbox_inches='tight')
    print("融合前最大投影图已保存: {}".format(before_path))
    
    max_projection = np.max(fusion, axis=0)
    
    plt.figure(figsize=(10, 8))
    plt.imshow(max_projection, cmap='hot')
    plt.colorbar(label='Intensity')
    plt.title('Maximum Projection of Fused Data')
    plt.axis('off')
    
    after_path = os.path.join(BASE_DIR, 'fusion_maxproj.png')
    plt.savefig(after_path, dpi=300, bbox_inches='tight', pad_inches=0)
    print("融合后最大投影图已保存: {}".format(after_path))
