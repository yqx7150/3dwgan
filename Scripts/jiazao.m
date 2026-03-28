


%% 填充加噪代码
% 定义不同的 SNR 值（添加SNR=0）
snr_values = [0, 15, 20, 25, 30];  % 新增0值

%% 数据保存修改部分
% 指定保存目录（确保所有保存操作使用统一路径）
saveDir = "C:\Users\lenovo\Desktop\data";  % 已正确设置指定路径

% 确保保存目录存在
if ~exist(saveDir, 'dir')
    mkdir(saveDir);  % 自动创建目录（如果不存在）
end

% 数据归一化到0-255范围
normalized_data = mat2gray(data5555_SNR25_fusion_cut) * 255;
uint8_data = uint8(normalized_data);

% 遍历每个 SNR 值，添加噪声并保存图像
for snr = snr_values
    % 处理无噪声情况
    if snr == 0
        noisy_image = data5555_SNR25_fusion_cut;  % 直接使用原始数据
    else
        % 基于信噪比公式 SNR = 10log10(Ps/Pn)
        signal_power = mean(data5555_SNR25_fusion_cut(:).^2); % 计算信号功率Ps
        target_snr_linear = 10^(snr/10);          % 将dB转换为线性比例
        noise_variance = signal_power / target_snr_linear; % 计算噪声方差Pn
        
        % 生成符合高斯分布的噪声
        % 调试点1：检查噪声生成量级（添加以下调试语句）
        fprintf('SNR%d 理论噪声标准差：%.2e\n', snr, sqrt(noise_variance));
        noise = sqrt(noise_variance) * randn(size(data5555_SNR25_fusion_cut));
        
        % 调试点2：验证噪声叠加有效性（添加以下语句）
        max_signal = max(data5555_SNR25_fusion_cut(:));
        max_noise = max(noise(:));
        fprintf('信号最大值：%.2f | 噪声最大值：%.2f (比例：%.2f%%)\n',...
                max_signal, max_noise, 100*max_noise/max_signal);
                
        noisy_image = data5555_SNR25_fusion_cut + noise;
    end
    
    % 保存三维加噪数据前添加验证（新增以下代码块）
    % 计算噪声功率对比
    original_power = 10*log10(var(data5555_SNR25_fusion_cut(:)));
    noisy_power = 10*log10(var(noisy_image(:)));
    disp(['SNR' num2str(snr) ' 噪声功率对比 || 原始：' num2str(original_power) 'dB → 加噪后：' num2str(noisy_power) 'dB']);

    % 生成对比图像（新增可视化代码）
    figure('Name', ['SNR=' num2str(snr) ' 加噪验证']);
    subplot(1,2,1);
    imagesc(squeeze(max(data5555_SNR25_fusion_cut))); % 原始数据投影
    title('原始数据投影');
    subplot(1,2,2);
    imagesc(squeeze(max(noisy_image))); % 加噪后投影
    title(['SNR=' num2str(snr) ' 加噪投影']); 
    colormap hot;
    drawnow;  % 立即刷新显示
    
    % 保存三维加噪数据（修正变量名匹配问题）
    mat_3d_filename = fullfile(saveDir, sprintf('data5555_PA_z3560_SNR%d_0_1_cut.mat', snr));  % 文件名与变量名统一
    data_var_name = sprintf('data5555_PA_z3560_SNR%d_0_1_cut', snr);  
    eval([data_var_name ' = noisy_image;']);
    save(mat_3d_filename, data_var_name);  
    
    %%% 新增三维噪声验证代码 %%%（保持不变）
    
    if snr > 0
        % 计算实际SNR
        noise_layer = noisy_image - data5555_SNR25_fusion_cut;
        signal_power_actual = mean(data5555_SNR25_fusion_cut(:).^2);
        noise_power_actual = mean(noise_layer(:).^2);
        actual_snr_db = 10*log10(signal_power_actual/noise_power_actual); % SNR验证公式
        
        % 显示三维噪声统计信息
        fprintf('SNR%d 噪声验证：\n',snr);
        fprintf('理论SNR：%ddB | 实际SNR：%.2fdB\n',snr,actual_snr_db);
        fprintf('噪声均值：%.2e 方差：%.2e\n',mean(noise_layer(:)),var(noise_layer(:)));
        
        % 显示噪声直方图
        figure;
        histogram(noise_layer,100);
        title(['SNR' num2str(snr) ' 噪声分布']);
        xlabel('噪声幅值');
    end
    
    % 创建二维最大投影图
    noisy_image_2d = squeeze(max(noisy_image));
    
    % 添加热力图转换
    scaled_data = mat2gray(noisy_image_2d); 
    hot_map = hot(256);
    rgb_image = ind2rgb(round(scaled_data*255), hot_map);
    rgb_image = im2uint8(rgb_image);

    % 构建保存路径
    proj_dir = fullfile(saveDir, 'max_projections(5)');
    if ~exist(proj_dir, 'dir')
        mkdir(proj_dir);
    end
    
    % 仅保存PNG图像（删除MAT文件保存）
    png_filename = fullfile(proj_dir, sprintf('z3560_SNR%d_maxproj.png', snr));
    imwrite(rgb_image, png_filename);
    
end  % 结束循环

% 添加路径验证代码（插入在disp语句前）
% 更新路径验证提示（移除投影路径）
disp("文件保存路径验证：");
disp("三维数据保存至: " + saveDir);  % 删除投影路径显示
disp("投影图保存至: " + proj_dir);



