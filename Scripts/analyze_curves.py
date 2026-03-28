import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt
import os


def analyze_curves(focus1_data, focus2_data, fusion_data):
    z_size, x_size, y_size = focus1_data.shape
    focus1_curve = focus1_data[:, x_size//2, y_size//2]
    focus1_curve = focus1_curve / np.max(focus1_curve)

    z_size, x_size, y_size = focus2_data.shape
    focus2_curve = focus2_data[:, x_size//2, y_size//2]
    focus2_curve = focus2_curve / np.max(focus2_curve)

    z_size, x_size, y_size = fusion_data.shape
    fusion_curve = fusion_data[:, x_size//2, y_size//2]
    fusion_curve = fusion_curve / np.max(fusion_curve)

    z_coords = np.linspace(0, 25, 43)

    print("Focus1 curve info:")
    print("  Max value: {:.4f}".format(np.max(focus1_curve)))
    print("  Max index: {}".format(np.argmax(focus1_curve)))
    print("  Half max: {:.4f}".format(np.max(focus1_curve)/2))
    print("  Values at boundaries: {:.4f}, {:.4f}".format(focus1_curve[0], focus1_curve[-1]))
    print("  Number of points above half max: {}".format(np.sum(focus1_curve > np.max(focus1_curve)/2)))

    print("\nFocus2 curve info:")
    print("  Max value: {:.4f}".format(np.max(focus2_curve)))
    print("  Max index: {}".format(np.argmax(focus2_curve)))
    print("  Half max: {:.4f}".format(np.max(focus2_curve)/2))
    print("  Values at boundaries: {:.4f}, {:.4f}".format(focus2_curve[0], focus2_curve[-1]))
    print("  Number of points above half max: {}".format(np.sum(focus2_curve > np.max(focus2_curve)/2)))

    print("\nFusion curve info:")
    print("  Max value: {:.4f}".format(np.max(fusion_curve)))
    print("  Max index: {}".format(np.argmax(fusion_curve)))
    print("  Half max: {:.4f}".format(np.max(fusion_curve)/2))
    print("  Values at boundaries: {:.4f}, {:.4f}".format(fusion_curve[0], fusion_curve[-1]))
    print("  Number of points above half max: {}".format(np.sum(fusion_curve > np.max(fusion_curve)/2)))

    return focus1_curve, focus2_curve, fusion_curve, z_coords


def plot_curves(focus1_curve, focus2_curve, fusion_curve, z_coords, output_path):
    plt.figure(figsize=(12, 8))
    
    plt.subplot(2, 2, 1)
    plt.plot(z_coords, focus1_curve, 'k-', linewidth=2)
    plt.axhline(y=np.max(focus1_curve)/2, color='r', linestyle='--', label='Half max')
    plt.title('Focus1 Curve')
    plt.xlabel('Z (um)')
    plt.ylabel('NPA')
    plt.legend()
    plt.grid(True)

    plt.subplot(2, 2, 2)
    plt.plot(z_coords, focus2_curve, 'b-', linewidth=2)
    plt.axhline(y=np.max(focus2_curve)/2, color='r', linestyle='--', label='Half max')
    plt.title('Focus2 Curve')
    plt.xlabel('Z (um)')
    plt.ylabel('NPA')
    plt.legend()
    plt.grid(True)

    plt.subplot(2, 2, 3)
    plt.plot(z_coords, fusion_curve, 'r-', linewidth=2)
    plt.axhline(y=np.max(fusion_curve)/2, color='r', linestyle='--', label='Half max')
    plt.title('Fusion Curve')
    plt.xlabel('Z (um)')
    plt.ylabel('NPA')
    plt.legend()
    plt.grid(True)

    plt.subplot(2, 2, 4)
    plt.plot(z_coords, focus1_curve, 'k-', linewidth=2, label='Focus1')
    plt.plot(z_coords, focus2_curve, 'b-', linewidth=2, label='Focus2')
    plt.plot(z_coords, fusion_curve, 'r-', linewidth=2, label='Fusion')
    plt.title('All Curves Comparison')
    plt.xlabel('Z (um)')
    plt.ylabel('NPA')
    plt.legend()
    plt.grid(True)

    plt.tight_layout()
    plt.savefig(output_path, dpi=150)
    plt.close()
    print("\n曲线分析图已保存为 {}".format(output_path))


if __name__ == '__main__':
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    DATA_DIR = os.path.join(BASE_DIR, 'Data')
    
    focus1_data = sio.loadmat(os.path.join(DATA_DIR, 'data19_PA_z35_SNR0_0_1_cut.mat'))
    focus1_data = focus1_data[list(focus1_data.keys())[-1]]
    
    focus2_data = sio.loadmat(os.path.join(DATA_DIR, 'data19_PA_z60_SNR0_0_1_cut.mat'))
    focus2_data = focus2_data[list(focus2_data.keys())[-1]]
    
    fusion_data = sio.loadmat(os.path.join(DATA_DIR, 'data19_PA_z3560_SNR0_0_1_cut.mat'))
    fusion_data = fusion_data[list(fusion_data.keys())[-1]]
    
    focus1_curve, focus2_curve, fusion_curve, z_coords = analyze_curves(focus1_data, focus2_data, fusion_data)
    
    output_path = os.path.join(BASE_DIR, 'curve_analysis.png')
    plot_curves(focus1_curve, focus2_curve, fusion_curve, z_coords, output_path)
