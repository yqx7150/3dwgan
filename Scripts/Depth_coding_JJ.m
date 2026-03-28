function depth_RGB2 = Depth_coding_JJ(map,IDX,map_range,depth_range,cmap)

% map: the MAP image of 3D data set, need to be normized by the maximum
% value

%IDX: the depth information of the 'map' image, can be obtained by function 'max', 
% please read the help document

%depth_range: the depth range you want to display in your figure, for
%example, you want to show the depth from 10 to 30 pixels in the axial
%direction, set depth_range to be [10 30]

% map_range: the brightness you want to display in your figure, for
% example, you want to show the intensity from 0.1 to 0.8, set map_range to
% be [0.1 0.8]

%cmap: the colormap you want to use for the depth coding, fox example,
%jet(256)

%depth_RGB2: the generated RGB figure for depth coding, can be shown using
%'imshow', or 'imagesc'


% map0 = map/max(map(:));
IDX = medfilt2(IDX,[3 3]);
map0 = map;
map0 = medfilt2(map0,[3 3]);
map3 = imadjust((map0/2+abs(map0)/2).^1,map_range);
map3 = map3;
depth_RGB = grs2rgb(IDX,cmap,depth_range,0);
depth_RGB2 = 0*depth_RGB;

map_RGB(:,:,1) = map3;
map_RGB(:,:,2) = map3;
map_RGB(:,:,3) = map3;

depth_RGB2 = depth_RGB.*map_RGB;