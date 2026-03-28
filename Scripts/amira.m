%% 参数设置（请确保这三个参数与数据维度一致）
z = 43;
x = 94;
y = 99;

%% 第一部分：处理 SNR0 数据（变量 fusion_pad）
outDir0 = "C:\Users\lenovo\Desktop\data111\data111_PA_z35_SNR0_0_1_cut";
mkdir(outDir0);
for j = 1:y
    slice = data111_PA_z35_SNR0_0_1_cut(:,:,j) * 10000;  % 单纯幅度缩放
    slice = abs(hilbert(double(slice)));  
    fileName = fullfile(outDir0, [num2str(j) '.raw']);
    fid = fopen(fileName, 'w');
    fwrite(fid, slice(1:z, 1:x), 'double');  
    fclose(fid);
end
%% 第一部分：处理 SNR0 数据（变量 fusion_pad）
outDir0 = "C:\Users\lenovo\Desktop\data111\data111_PA_z35_SNR15_0_1_cut";
mkdir(outDir0);
for j = 1:y
    slice = data111_PA_z35_SNR15_0_1_cut(:,:,j) * 10000;  % 单纯幅度缩放
    slice = abs(hilbert(double(slice)));  
    fileName = fullfile(outDir0, [num2str(j) '.raw']);
    fid = fopen(fileName, 'w');
    fwrite(fid, slice(1:z, 1:x), 'double');  
    fclose(fid);
end

%% 第一部分：处理 SNR0 数据（变量 fusion_pad）
outDir0 = "C:\Users\lenovo\Desktop\data111\data111_PA_z35_SNR20_0_1_cut";
mkdir(outDir0);
for j = 1:y
    slice = data111_PA_z35_SNR20_0_1_cut(:,:,j) * 10000;  % 单纯幅度缩放
    slice = abs(hilbert(double(slice)));  
    fileName = fullfile(outDir0, [num2str(j) '.raw']);
    fid = fopen(fileName, 'w');
    fwrite(fid, slice(1:z, 1:x), 'double');  
    fclose(fid);
end

%% 第一部分：处理 SNR0 数据（变量 fusion_pad）
outDir0 = "C:\Users\lenovo\Desktop\data111\data111_PA_z35_SNR25_0_1_cut";
mkdir(outDir0);
for j = 1:y
    slice = data111_PA_z35_SNR25_0_1_cut(:,:,j) * 10000;  % 单纯幅度缩放
    slice = abs(hilbert(double(slice)));  
    fileName = fullfile(outDir0, [num2str(j) '.raw']);
    fid = fopen(fileName, 'w');
    fwrite(fid, slice(1:z, 1:x), 'double');  
    fclose(fid);
end

%% 第一部分：处理 SNR0 数据（变量 fusion_pad）
outDir0 = "C:\Users\lenovo\Desktop\data111\data111_PA_z35_SNR30_0_1_cut";
mkdir(outDir0);
for j = 1:y
    slice = data111_PA_z35_SNR30_0_1_cut(:,:,j) * 10000;  % 单纯幅度缩放
    slice = abs(hilbert(double(slice)));  
    fileName = fullfile(outDir0, [num2str(j) '.raw']);
    fid = fopen(fileName, 'w');
    fwrite(fid, slice(1:z, 1:x), 'double');  
    fclose(fid);
end






disp("所有数据已成功保存到指定文件夹！");
