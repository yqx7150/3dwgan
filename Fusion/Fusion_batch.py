# 批量融合处理（无权重版本）
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
    
    data_pairs = [
        ('wusi0123a.mat', 'wusi0123b.mat', 'wusi0123_fusion'),
    ]
    
    print("开始批量融合处理...")
    
    for z35_file, z60_file, output_name in data_pairs:
        print("\n处理 {}...".format(output_name))
        
        z35_path = os.path.join(BASE_DIR, 'Data', z35_file)
        z60_path = os.path.join(BASE_DIR, 'Data', z60_file)
        
        if not os.path.exists(z35_path) or not os.path.exists(z60_path):
            print("文件不存在，跳过: {} 或 {}".format(z35_path, z60_path))
            continue
        
        data_z35 = scipy.io.loadmat(z35_path)
        data_z60 = scipy.io.loadmat(z60_path)
        
        focus_A = data_z35[list(data_z35.keys())[-1]]
        focus_B = data_z60[list(data_z60.keys())[-1]]
        
        print("数据加载完成: focus_A shape={}, focus_B shape={}".format(focus_A.shape, focus_B.shape))
        
        decision_map = np.ones(focus_A.shape, dtype=np.float32) * 0.5
        
        fusion = volumetric_information_fusion(focus_A, focus_B, sigma, radius, decision_map)
        print("融合完成: shape={}, range=[{:.4f}, {:.4f}]".format(fusion.shape, fusion.min(), fusion.max()))
        
        output_dir = os.path.join(BASE_DIR, 'Data')
        fusion_results = {output_name: fusion}
        output_path = os.path.join(output_dir, '{}.mat'.format(output_name))
        scipy.io.savemat(output_path, fusion_results)
        print("结果已保存: {}".format(output_path))
        
        proj_dir = os.path.join(BASE_DIR, 'max_projections')
        os.makedirs(proj_dir, exist_ok=True)
        
        proj_z35 = np.max(focus_A, axis=0)
        proj_z60 = np.max(focus_B, axis=0)
        proj_fusion = np.max(fusion, axis=0)
        
        plt.figure(figsize=(18, 5))
        
        plt.subplot(131)
        plt.imshow(proj_z35, cmap='hot')
        plt.title('Focus Z=35')
        plt.axis('off')
        
        plt.subplot(132)
        plt.imshow(proj_z60, cmap='hot')
        plt.title('Focus Z=60')
        plt.axis('off')
        
        plt.subplot(133)
        plt.imshow(proj_fusion, cmap='hot')
        plt.title('Fusion')
        plt.axis('off')
        
        plt.tight_layout()
        plt.savefig(os.path.join(proj_dir, 'max_projection_{}.png'.format(output_name)), dpi=150, bbox_inches='tight')
        plt.close()
        print("最大投影图已保存")
    
    print("\n批量融合处理完成!")
