%% 35焦点归一化
% 假设 X 是你的原始数据矩阵，每行是一个数据点，每列是一个特征
X = data_PA;

% 计算每个特征的最大值和最小值
X_maxVals = max(X(:));
X_minVals = min(X(:));

disp(X_maxVals);
disp(X_minVals);
% 归一化数据
data1_PA_z35_SNR0_0_1= X ./ X_maxVals;

disp(max(data1_PA_z35_SNR0_0_1(:)));
disp(min(data1_PA_z35_SNR0_0_1(:)));

%% 60焦点归一化
Y =data_PA;

% 计算每个特征的最大值和最小值
Y_maxVals = max(Y(:));
Y_minVals = min(Y(:));

disp(Y_maxVals);
disp(Y_minVals);
% 归一化数据
data19_PA_z60_SNR0_0_1 = Y ./ Y_maxVals;

disp(max(data19_PA_z60_SNR0_0_1(:)));
disp(min(data19_PA_z60_SNR0_0_1(:)));

%% 加噪代码
% 聚焦位置为35
data19_PA_z35_SNR10_0_1 = addNoise(data19_PA_z35_SNR0_0_1, 10, 'peak');
data19_PA_z35_SNR15_0_1 = addNoise(data19_PA_z35_SNR0_0_1, 15, 'peak');
data19_PA_z35_SNR20_0_1 = addNoise(data19_PA_z35_SNR0_0_1, 20, 'peak');
data19_PA_z35_SNR25_0_1 = addNoise(data19_PA_z35_SNR0_0_1, 25, 'peak');
data19_PA_z35_SNR30_0_1 = addNoise(data19_PA_z35_SNR0_0_1, 30, 'peak');
data19_PA_z35_SNR35_0_1 = addNoise(data19_PA_z35_SNR0_0_1, 35, 'peak');
% 聚焦位置为60
data19_PA_z60_SNR10_0_1 = addNoise(data19_PA_z60_SNR0_0_1, 10, 'peak');
data19_PA_z60_SNR15_0_1 = addNoise(data19_PA_z60_SNR0_0_1, 15, 'peak');
data19_PA_z60_SNR20_0_1 = addNoise(data19_PA_z60_SNR0_0_1, 20, 'peak');
data19_PA_z60_SNR25_0_1 = addNoise(data19_PA_z60_SNR0_0_1, 25, 'peak');
data19_PA_z60_SNR30_0_1 = addNoise(data19_PA_z60_SNR0_0_1, 30, 'peak');
data19_PA_z60_SNR35_0_1 = addNoise(data19_PA_z60_SNR0_0_1, 35, 'peak');
save('D:\dataPA\data19_PA_z35_SNR10_0_1','data11_PA_z35_SNR10_0_1')
save('D:\dataPA\data11_PA_z35_SNR15_0_1','data11_PA_z35_SNR15_0_1')
save('D:\dataPA\data11_PA_z35_SNR20_0_1','data11_PA_z35_SNR20_0_1')
save('D:\dataPA\data11_PA_z35_SNR25_0_1','data11_PA_z35_SNR25_0_1')
save('D:\dataPA\data11_PA_z35_SNR30_0_1','data11_PA_z35_SNR30_0_1')
save('D:\dataPA\data11_PA_z35_SNR35_0_1','data11_PA_z35_SNR35_0_1')
save('D:\dataPA\data11_PA_z60_SNR10_0_1','data11_PA_z60_SNR10_0_1')
save('D:\dataPA\data11_PA_z60_SNR15_0_1','data11_PA_z60_SNR15_0_1')
save('D:\dataPA\data11_PA_z60_SNR10_0_1','data11_PA_z60_SNR10_0_1')
save('D:\dataPA\data11_PA_z60_SNR20_0_1','data11_PA_z60_SNR20_0_1')
save('D:\dataPA\data11_PA_z60_SNR25_0_1','data11_PA_z60_SNR25_0_1')
save('D:\dataPA\data11_PA_z60_SNR30_0_1','data11_PA_z60_SNR30_0_1')
save('D:\dataPA\data11_PA_z60_SNR35_0_1','data11_PA_z60_SNR35_0_1')
%% 剪切代码 
% 定义要提取的子集的索引范
xRange = 5:45; % 第一维的索引范围           
yRange = 1:76; % 第二维的索引范围           
zRange = 1:101; % 第三维的索引范围           

% 提取子集
data19_PA_z35_SNR0_0_1_cut = data19_PA_z35_SNR0_0_1(xRange, yRange, zRange);
data19_PA_z35_SNR15_0_1_cut = data19_PA_z35_SNR15_0_1(xRange, yRange, zRange);
data19_PA_z35_SNR20_0_1_cut = data19_PA_z35_SNR20_0_1(xRange, yRange, zRange);
data19_PA_z35_SNR25_0_1_cut = data19_PA_z35_SNR25_0_1(xRange, yRange, zRange);
data19_PA_z35_SNR30_0_1_cut = data19_PA_z35_SNR30_0_1(xRange, yRange, zRange);
data19_PA_z35_SNR35_0_1_cut = data19_PA_z35_SNR35_0_1(xRange, yRange, zRange);

data19_PA_z60_SNR0_0_1_cut = data19_PA_z60_SNR0_0_1(xRange, yRange, zRange);
data19_PA_z60_SNR15_0_1_cut = data19_PA_z60_SNR15_0_1(xRange, yRange, zRange);
data19_PA_z60_SNR20_0_1_cut = data19_PA_z60_SNR20_0_1(xRange, yRange, zRange);
data19_PA_z60_SNR25_0_1_cut = data19_PA_z60_SNR25_0_1(xRange, yRange, zRange);
data19_PA_z60_SNR30_0_1_cut = data19_PA_z60_SNR30_0_1(xRange, yRange, zRange);
data19_PA_z60_SNR35_0_1_cut = data19_PA_z60_SNR35_0_1(xRange, yRange, zRange);

save('D:\dataPA\data19_PA_z35_SNR0_0_1_cut','data19_PA_z35_SNR0_0_1_cut')
save('D:\dataPA\data19_PA_z35_SNR15_0_1_cut','data19_PA_z35_SNR15_0_1_cut')
save('D:\dataPA\data19_PA_z35_SNR20_0_1_cut','data19_PA_z35_SNR20_0_1_cut')
save('D:\dataPA\data19_PA_z35_SNR25_0_1_cut','data19_PA_z35_SNR25_0_1_cut')
save('D:\dataPA\data19_PA_z35_SNR30_0_1_cut','data19_PA_z35_SNR30_0_1_cut')
save('D:\dataPA\data19_PA_z35_SNR35_0_1_cut','data19_PA_z35_SNR35_0_1_cut')
save('D:\dataPA\data19_PA_z60_SNR0_0_1_cut','data19_PA_z60_SNR0_0_1_cut')
save('D:\dataPA\data19_PA_z60_SNR15_0_1_cut','data19_PA_z60_SNR15_0_1_cut')
save('D:\dataPA\data19_PA_z60_SNR20_0_1_cut','data19_PA_z60_SNR20_0_1_cut')
save('D:\dataPA\data19_PA_z60_SNR25_0_1_cut','data19_PA_z60_SNR25_0_1_cut')
save('D:\dataPA\data19_PA_z60_SNR30_0_1_cut','data19_PA_z60_SNR30_0_1_cut')
save('D:\dataPA\data19_PA_z60_SNR35_0_1_cut','data19_PA_z60_SNR35_0_1_cut')

%% 图像处理
clear all;
% 读取图像
img = imread("F:\MFIF\date18.png");  % 确保替换为你的图像文件路径
[rows, cols, ~] = size(img);
if size(img, 3) == 3
    resized_img = rgb2gray(img);
elseif size(img, 3) == 1
    resized_img = img;
end
bw = imbinarize(resized_img);
bw = ~bw;
imshow(bw)
% 新增：保存二值化后的图像
outputPath = "F:\MFIF\date181.png"; % 替换为你想要保存的路径
imwrite(bw, outputPath);
%% 最大投影图查看'
figure;
imagesc(squeeze(max(data13_PA_z30_SNR0)));
colormap('hot');
axis off;


figure;
imagesc(squeeze(max(data13_PA_z60_SNR0)));
colormap('hot');
axis off;

data13_PA_z30_SNR20
figure;
imagesc(squeeze(max(data13_PA_z60_SNR15)));
colormap('hot');
axis off;


figure;
imagesc(squeeze(max(dataGroup40_cut)));
colormap('hot');
axis off;

figure;
imagesc(squeeze(max(dataGroup70_cut)));
colormap('hot');
axis off;


figure;
imagesc(squeeze(max(dataGroup40_70_cut)));
colormap('hot');
axis off;

figure;
imagesc(squeeze(max(dataGroup70_cut)));
colormap('hot');
axis off;

%% 数据填充
originalData = dataxianwei_PA_z70_SNR0_0_1;
% 定义新的维度大小
newSizeX = 256;
newSizeY = 140;
newSizeZ = 140;

% 计算每个维度需要填充的大小
padSizeY = (newSizeY - size(originalData, 2))/2;
padSizeZ = (newSizeZ - size(originalData, 3))/2;

% 使用 padarray 函数在Y和Z维度的前后填充0
paddedData = padarray(originalData, [0, 0, padSizeZ], 0, 'pre');
paddedData = padarray(paddedData, [0, 0, padSizeZ], 0, 'post');
paddedData = padarray(paddedData, [0, padSizeY, 0], 0, 'pre');
paddedData = padarray(paddedData, [0, padSizeY, 0], 0, 'post');

% 验证填充后的数据大小
disp(size(paddedData));

%% %% 数据填充
originalData = real_data1_60_cut;
% 定义新的维度大小
newSizeX = 141;
newSizeY = 240;
newSizeZ = 240;

% 计算每个维度需要填充的大小
padSizeY = (newSizeY - size(originalData, 2))/2;
padSizeZ = (newSizeZ - size(originalData, 3))/2;

% 使用 padarray 函数在Y和Z维度的左右两边各填充20个0数据
% 首先在Y和Z维度的左侧填充20个0
real_data1_60_cut_pad = padarray(originalData, [0, 20, 20], 0, 'pre');
% 然后在Y和Z维度的右侧填充剩余的0
real_data1_60_cut_pad = padarray(real_data1_60_cut_pad, [0, floor(padSizeY), floor(padSizeZ)], 0, 'post');

% 确保填充后的尺寸符合要求
if size(real_data1_60_cut_pad, 2) ~= newSizeY
    error('Padding in Y dimension is incorrect.');
end
if size(real_data1_60_cut_pad, 3) ~= newSizeZ
    error('Padding in Z dimension is incorrect.');
end

% 验证填充后的数据大小
disp(size(real_data1_60_cut_pad));
figure;
imagesc(squeeze(max(real_data1_60_cut_pad)));
colormap('hot');
axis off;
save("G:/real_data1_60_cut_pad","real_data1_60_cut_pad")

%% 数据填充2
%% 数据填充
originalData = wusi3_4;

% 显示原始数据大小
disp('Original Data Size:');
disp(size(originalData));

% 剪裁 Z 轴最右侧 10 个像素
croppedData = originalData(:, :, 1:end-10);

% 在 Z 轴左侧增加 10 个像素宽度，用 0-0.1 之间的随机数填充
leftPadZ = rand(size(croppedData, 1), size(croppedData, 2), 10) * 0.1;

% 拼接填充后的数据到 Z 轴左侧
paddedData = cat(3, leftPadZ, croppedData);

% 显示填充后的数据大小
disp('Padded Data Size:');
disp(size(paddedData));

% 绘制结果图像（最大投影）
figure;
imagesc(squeeze(max(paddedData)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息形窗口
axis off;


% 保存结果
save("G:/real_data1_60_cut_pad", "paddedData");

%% 
% 数据填充，右边减掉10，左边补充10的0
originalData = wusi1_f5_0_1;

% 显示原始数据大小
disp('Original Data Size:');
disp(size(originalData));

% 剪裁 Z 轴最右侧 10 个像素
croppedData = originalData(:, :, 1:end-10);

% 在 Z 轴左侧增加 10 个像素宽度，用 0 填充
leftPadZ = zeros(size(croppedData, 1), size(croppedData, 2), 10);

% 拼接填充后的数据到 Z 轴左侧
paddedData = cat(3, leftPadZ, croppedData);

% 显示填充后的数据大小
disp('Padded Data Size:');
disp(size(paddedData));

% 绘制结果图像（最大投影）
figure;
imagesc(squeeze(max(paddedData)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi1_f5_0_1_pad=paddedData;

% 保存结果
save("E:\\data_PA\\show_data\\wusi\\wusi1\\wusi1_f5_0_1_pad.mat", "wusi1_f5_0_1_pad");

%% 两边各10的0.左边补，右边改10

% 数据填充
originalData = wusi3_4;

% 显示原始数据大小
disp('Original Data Size:');
disp(size(originalData));

% 剪裁掉 Z 轴最右侧 10 个像素
croppedData = originalData(:, :, 1:end-10);

% 在 Z 轴左侧增加 10 个像素宽度，用 0 填充
leftPadZ = zeros(size(croppedData, 1), size(croppedData, 2), 10);

% 在 Z 轴右侧增加 10 个像素宽度，用 0 填充
rightPadZ = zeros(size(croppedData, 1), size(croppedData, 2), 10);

% 拼接填充后的数据到 Z 轴左侧和右侧
paddedData = cat(3, leftPadZ, croppedData, rightPadZ);

% 显示填充后的数据大小
disp('Padded Data Size:');
disp(size(paddedData));

% 绘制结果图像（最大投影）
figure;
imagesc(squeeze(max(paddedData)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi3_4_pad2 = paddedData;

% 保存结果
save("E:\\data_PA\\show_data\\wusi\\wusi1\\wusi3_4_pad2.mat", "wusi3_4_pad2");

%252x100x110 double



%% 两边各10的0.左边补，右边也补10
%% 剪切代码 
% 定义要提取的子集的索引范
xRange = 450:560; % 第一维的索引范围           
yRange = 1:100; % 第二维的索引范围           
zRange = 1:100; % 第三维的索引范围           

% 提取子集
wusi3_f6_cut = wusi3_f6(xRange, yRange, zRange);
% data2_PA_z35_SNR15_0_1_cut = data2_PA_z35_SNR15_0_1(xRange, yRange, zRange);
% data2_PA_z35_SNR20_0_1_cut = data2_PA_z35_SNR20_0_1(xRange, yRange, zRange);
% data2_PA_z35_SNR25_0_1_cut = data2_PA_z35_SNR25_0_1(xRange, yRange, zRange);
% data2_PA_z35_SNR30_0_1_cut = data2_PA_z35_SNR30_0_1(xRange, yRange, zRange);
% data2_PA_z35_SNR35_0_1_cut = data2_PA_z35_SNR35_0_1(xRange, yRange, zRange);

wusi3_f7_cut = wusi3_f7(xRange, yRange, zRange);
% data2_PA_z60_SNR15_0_1_cut = data2_PA_z60_SNR15_0_1(xRange, yRange, zRange);
% data2_PA_z60_SNR20_0_1_cut = data2_PA_z60_SNR20_0_1(xRange, yRange, zRange);
% data2_PA_z60_SNR25_0_1_cut = data2_PA_z60_SNR25_0_1(xRange, yRange, zRange);
% data2_PA_z60_SNR30_0_1_cut = data2_PA_z60_SNR30_0_1(xRange, yRange, zRange);
% data2_PA_z60_SNR35_0_1_cut = data2_PA_z60_SNR35_0_1(xRange, yRange, zRange);

% save("G:\dataGroup2_cut", ...
%     "data2_PA_z35_SNR0_0_1_cut","data2_PA_z35_SNR15_0_1_cut","data2_PA_z35_SNR20_0_1_cut", ...
%     "data2_PA_z35_SNR25_0_1_cut","data2_PA_z35_SNR30_0_1_cut","data2_PA_z35_SNR35_0_1_cut", ...
%     "data2_PA_z60_SNR0_0_1_cut","data2_PA_z60_SNR15_0_1_cut","data2_PA_z60_SNR20_0_1_cut", ...
%     "data2_PA_z60_SNR25_0_1_cut","data2_PA_z60_SNR30_0_1_cut","data2_PA_z60_SNR35_0_1_cut");

save('E:\data_PA\CNN_data\show_data\wusi\wusi3(50um)\wusi3_f6_cut.mat', 'wusi3_f6_cut');


save('E:\data_PA\CNN_data\show_data\wusi\wusi3(50um)\wusi3_f7_cut.mat', 'wusi3_f7_cut');
% 数据填充
% 数据填充
originalData = wusi3_f6_cut;        %要改

% 显示原始数据大小
disp('Original Data Size:');
disp(size(originalData));

% 在 Z 轴左侧增加 10 个像素宽度，用 0 填充
leftPadZ = zeros(size(originalData, 1), size(originalData, 2), 10);

% 在 Z 轴右侧增加 10 个像素宽度，用 0 填充
rightPadZ = zeros(size(originalData, 1), size(originalData, 2), 10);

% 拼接填充后的数据到 Z 轴左侧和右侧
paddedDataZ = cat(3, leftPadZ, originalData, rightPadZ);

% 在 Y 轴上侧增加 10 个像素宽度，用 0 填充
topPadY = zeros(size(paddedDataZ, 1), 10, size(paddedDataZ, 3));

% 在 Y 轴下侧增加 10 个像素宽度，用 0 填充
bottomPadY = zeros(size(paddedDataZ, 1), 10, size(paddedDataZ, 3));

% 拼接填充后的数据到 Y 轴上下两侧
paddedData = cat(2, topPadY, paddedDataZ, bottomPadY);

% 显示填充后的数据大小
disp('Padded Data Size:');
disp(size(paddedData));

% 绘制结果图像（最大投影）
figure;
imagesc(squeeze(max(paddedData)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi3_f6_cut_pad = paddedData;                                    %要改

% 保存结果
save("E:\\data_PA\\CNN_data\\show_data\\wusi\\wusi3(50um)\\wusi3_f6_cut_pad.mat", "wusi3_f6_cut_pad");                  %要改


% 数据填充
% 数据填充
originalData = wusi3_f7_cut;        %要改

% 显示原始数据大小
disp('Original Data Size:');
disp(size(originalData));

% 在 Z 轴左侧增加 10 个像素宽度，用 0 填充
leftPadZ = zeros(size(originalData, 1), size(originalData, 2), 10);

% 在 Z 轴右侧增加 10 个像素宽度，用 0 填充
rightPadZ = zeros(size(originalData, 1), size(originalData, 2), 10);

% 拼接填充后的数据到 Z 轴左侧和右侧
paddedDataZ = cat(3, leftPadZ, originalData, rightPadZ);

% 在 Y 轴上侧增加 10 个像素宽度，用 0 填充
topPadY = zeros(size(paddedDataZ, 1), 10, size(paddedDataZ, 3));

% 在 Y 轴下侧增加 10 个像素宽度，用 0 填充
bottomPadY = zeros(size(paddedDataZ, 1), 10, size(paddedDataZ, 3));

% 拼接填充后的数据到 Y 轴上下两侧
paddedData = cat(2, topPadY, paddedDataZ, bottomPadY);

% 显示填充后的数据大小
disp('Padded Data Size:');
disp(size(paddedData));

% 绘制结果图像（最大投影）
figure;
imagesc(squeeze(max(paddedData)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi3_f7_cut_pad = paddedData;                                    %要改

% 保存结果
save("E:\\data_PA\\CNN_data\\show_data\\wusi\\wusi3(50um)\\wusi3_f7_cut_pad.mat", "wusi3_f7_cut_pad");                  %要改


%% 剪切上下左右各10宽度
% 数据填充
originalData = wusi3_f3_cut;

% 显示原始数据大小
disp('Original Data Size:');
disp(size(originalData));

% 剪切掉 Y 轴上下两侧各 10 个像素宽度
croppedDataY = originalData(:, 11:end-10, :);

% 剪切掉 Z 轴左右两侧各 10 个像素宽度
croppedData = croppedDataY(:, :, 11:end-10);

% 显示剪切后的数据大小
disp('Cropped Data Size:');
disp(size(croppedData));

% 绘制结果图像（最大投影）
figure;
imagesc(squeeze(max(croppedData)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi3_f3_cut_pad = croppedData;

% 保存结果
save("E:\\data_PA\\show_data\\wusi\\wusi1\\wusi3_f3_cut_pad.mat", "wusi3_f3_cut_pad");



%% 

figure;
imagesc(squeeze(max(data_PA)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi3_4_pad2 = croppedData;

figure;
imagesc(squeeze(max(wusi3_4_pad2)));
colormap('hot');
impixelinfo;  % 在图像窗口中显示像素信息
axis off;
wusi3_4_pad2 = croppedData;

%% 保存图片

figure;
imagesc(squeeze(max(data15_PA_z35_SNR0)));
colormap('hot');
axis off;
axis tight;
set(gca, 'LooseInset', get(gca, 'TightInset')); % 去除边框

% 指定文件保存地址
outputPath = 'E:\data_PA\CNN_data\figure\15data35_source.png'; % 替换为你的目标路径
print(outputPath, '-dpng', '-r300'); % 保存图片


figure;
imagesc(squeeze(max(data15_PA_z60_SNR0)));
colormap('hot');
% impixelinfo;  % 在图像窗口中显示像素信息
axis off;
axis tight;
set(gca, 'LooseInset', get(gca, 'TightInset')); % 去除边框
% 指定文件保存地址
outputPath = 'E:\data_PA\CNN_data\figure\15data60_source.png';  % 替换为你的目标路径
print(outputPath, '-dpng', '-r300');  % 保存图片









