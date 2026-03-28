import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt
import os


def load_data(base_path, focus1_file, focus2_file, fusion_file):
    focus1_data = sio.loadmat(os.path.join(base_path, focus1_file))[list(sio.loadmat(os.path.join(base_path, focus1_file)).keys())[-1]]
    focus2_data = sio.loadmat(os.path.join(base_path, focus2_file))[list(sio.loadmat(os.path.join(base_path, focus2_file)).keys())[-1]]
    fusion_data = sio.loadmat(os.path.join(base_path, fusion_file))[list(sio.loadmat(os.path.join(base_path, fusion_file)).keys())[-1]]
    return focus1_data, focus2_data, fusion_data


def compare_data(focus1_data, focus2_data, fusion_data):
    print("数据形状：")
    print("Focus1: {}".format(focus1_data.shape))
    print("Focus2: {}".format(focus2_data.shape))
    print("Fusion: {}".format(fusion_data.shape))

    print("\n数据比较：")
    print("Focus1 == Focus2: {}".format(np.array_equal(focus1_data, focus2_data)))
    print("Focus1 == Fusion: {}".format(np.array_equal(focus1_data, fusion_data)))
    print("Focus2 == Fusion: {}".format(np.array_equal(focus2_data, fusion_data)))

    print("\n数据统计：")
    print("Focus1 - min: {:.4f}, max: {:.4f}, mean: {:.4f}".format(np.min(focus1_data), np.max(focus1_data), np.mean(focus1_data)))
    print("Focus2 - min: {:.4f}, max: {:.4f}, mean: {:.4f}".format(np.min(focus2_data), np.max(focus2_data), np.mean(focus2_data)))
    print("Fusion - min: {:.4f}, max: {:.4f}, mean: {:.4f}".format(np.min(fusion_data), np.max(fusion_data), np.mean(fusion_data)))


def find_peak_position(data, name):
    max_val = np.max(data)
    peak_idx = np.unravel_index(np.argmax(data), data.shape)
    print("{} 峰值位置: z={}, x={}, y={}, value={:.4f}".format(name, peak_idx[0], peak_idx[1], peak_idx[2], max_val))
    return peak_idx


def calculate_fwhm_detailed(curve, z_coords, name):
    peak_idx = np.argmax(curve)
    peak_value = curve[peak_idx]
    half_max = peak_value / 2
    
    print("\n{} FWHM计算：".format(name))
    print("  峰值索引: {}, 峰值: {:.4f}".format(peak_idx, peak_value))
    print("  半高值: {:.4f}".format(half_max))
    
    left_idx = peak_idx
    while left_idx > 0 and curve[left_idx] > half_max:
        left_idx -= 1
    
    right_idx = peak_idx
    while right_idx < len(curve) - 1 and curve[right_idx] > half_max:
        right_idx += 1
    
    print("  左侧半高索引: {}, 值: {:.4f}".format(left_idx, curve[left_idx]))
    print("  右侧半高索引: {}, 值: {:.4f}".format(right_idx, curve[right_idx]))
    
    if left_idx == 0 or right_idx == len(curve) - 1:
        print("  FWHM: 无法计算（边界问题）")
        return None
    
    fwhm = z_coords[right_idx] - z_coords[left_idx]
    print("  FWHM: {:.2f} um".format(fwhm))
    return fwhm


def plot_comparison(curve1, curve2, curve3, z_coords, output_path):
    plt.figure(figsize=(12, 8))
    plt.plot(z_coords, curve1, 'k-', linewidth=2, label='Focus1', alpha=0.7)
    plt.plot(z_coords, curve2, 'b-', linewidth=2, label='Focus2', alpha=0.7)
    plt.plot(z_coords, curve3, 'r--', linewidth=2, label='Fusion', alpha=0.7)
    plt.xlabel('Z (um)', fontsize=14)
    plt.ylabel('NPA', fontsize=14)
    plt.title('Comparison of Three Curves', fontsize=16)
    plt.legend(fontsize=12)
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(output_path, dpi=150)
    plt.close()
    print("\n曲线对比图已保存为 {}".format(output_path))


if __name__ == '__main__':
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    DATA_DIR = os.path.join(BASE_DIR, 'Data')
    
    focus1_file = 'data19_PA_z35_SNR0_0_1_cut.mat'
    focus2_file = 'data19_PA_z60_SNR0_0_1_cut.mat'
    fusion_file = 'data19_PA_z3560_SNR0_0_1_cut.mat'
    
    focus1_data, focus2_data, fusion_data = load_data(DATA_DIR, focus1_file, focus2_file, fusion_file)
    compare_data(focus1_data, focus2_data, fusion_data)
    
    print("\n峰值位置：")
    peak1 = find_peak_position(focus1_data, "Focus1")
    peak2 = find_peak_position(focus2_data, "Focus2")
    peak3 = find_peak_position(fusion_data, "Fusion")
    
    z_coords = np.linspace(0, 25, 43)
    
    curve1 = focus1_data[:, peak1[1], peak1[2]]
    curve2 = focus2_data[:, peak2[1], peak2[2]]
    curve3 = fusion_data[:, peak3[1], peak3[2]]
    
    curve1 = curve1 / np.max(curve1)
    curve2 = curve2 / np.max(curve2)
    curve3 = curve3 / np.max(curve3)
    
    print("\n曲线比较：")
    print("Curve1 == Curve2: {}".format(np.array_equal(curve1, curve2)))
    print("Curve1 == Curve3: {}".format(np.array_equal(curve1, curve3)))
    print("Curve2 == Curve3: {}".format(np.array_equal(curve2, curve3)))
    
    print("\n曲线差异：")
    print("Curve1 vs Curve2 - max diff: {:.6f}".format(np.max(np.abs(curve1 - curve2))))
    print("Curve1 vs Curve3 - max diff: {:.6f}".format(np.max(np.abs(curve1 - curve3))))
    print("Curve2 vs Curve3 - max diff: {:.6f}".format(np.max(np.abs(curve2 - curve3))))
    
    output_path = os.path.join(BASE_DIR, 'curve_comparison.png')
    plot_comparison(curve1, curve2, curve3, z_coords, output_path)
    
    calculate_fwhm_detailed(curve1, z_coords, "Focus1")
    calculate_fwhm_detailed(curve2, z_coords, "Focus2")
    calculate_fwhm_detailed(curve3, z_coords, "Fusion")
