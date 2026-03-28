% 剪切代码  
% 加载原始数据文件
try
    load('C:\Users\lenovo\Desktop\data19\data5555_PA_z60_SNR0.mat', 'data_PA');
catch
    disp('加载 data19_SNR0_fusion_pad 失败');
end

% 定义要提取的子集的索引范围
xRange = 1:256;          
yRange = 1:120;
zRange = 1:120;

% 提取子集
data5555_PA_z60_SNR0_cut = data_PA(xRange, yRange, zRange);

% 保存提取后的子集
if exist('data5555_PA_z60_SNR0_cut', 'var')
    save('C:\Users\lenovo\Desktop\data19\data5555_PA_z60_SNR0_cut.mat', 'data5555_PA_z60_SNR0_cut');
end





