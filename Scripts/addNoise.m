function noisy_image = add_noise(input_image, snr)
    % 根据给定的SNR值添加高斯噪声
    % 输入：
    % input_image - 原始图像
    % snr - 信噪比（dB）
    % 输出：
    % noisy_image - 加噪后的图像

    % 计算对应的噪声方差
    noise_variance = 10^(-snr/10);
    
    % 添加高斯噪声
    noisy_image = imnoise(input_image, 'gaussian', 0, noise_variance);

snr_values = [15, 20, 25, 30];
end

