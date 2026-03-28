% modified for Ruiying on Aug 30, 2015
% [map] is the MAP of raw RF sigal
% [IDX] is the index of the maxima 

% clear all;close all;clc;
map=double(MAP);%f1s1;
dim = size(map);
Y_div = 1; % y_step_size / x_step_size 
IDX= MAPref;
%% preprocess the MAP


map(isinf(map)) = 0;
map2 = map/max(map(:));
H = fspecial('average',[2 3]) ;
map2 = imfilter(map2, H, 'replicate');
map3 = abs(map2.^0.8);  % 原为0.6，增大幂次增强亮区对比度
map3 = imadjust(map3);

cmap = winter(128);
map_RGB = Depth_coding_JJ(map3,IDX,[0.2 0.8],[10 25],cmap); % 根据实际深度值调整范围
map_show1 = imresize(map_RGB,[dim(1)*Y_div,dim(2)]*1);

% 调整赋值部分的矩阵尺寸
result = zeros(94, 99, 3); % 初始化尺寸与右侧匹配
result(:,:,1) = map_show1(1:99,1:94,1)';
result(:,:,2) = map_show1(1:99,1:94,2)'; 
result(:,:,3) = map_show1(1:99,1:94,3)';
figure;imshow(result(1:94,1:94,:),[],'border','tight');
% figure;imshow(map_show1(1:60,1:60,:),[],'border','tight');
% figure; imshow((map_show1()));
% set (gcf,'Position',[100,100,1*1000,1*600]);
% axis normal;
