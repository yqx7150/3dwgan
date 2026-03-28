function res = grs2rgb(img, map, Clim, mode)

%%Convert grayscale images to RGB using specified colormap.
%	IMG is the grayscale image. Must be specified as a name of the image 
%	including the directory, or the matrix.
%	MAP is the M-by-3 matrix of colors.
%
%	RES = GRS2RGB(IMG) produces the RGB image RES from the grayscale image IMG 
%	using the colormap HOT with 64 colors.
%
%	RES = GRS2RGB(IMG,MAP) produces the RGB image RES from the grayscale image 
%	IMG using the colormap matrix MAP. MAP must contain 3 columns for Red, 
%	Green, and Blue components.  
%
%	Example 1:
%	open 'image.tif';	
%	res = grs2rgb(image);
%
%	Example 2:
%	cmap = colormap(summer);
% 	res = grs2rgb('image.tif',cmap);
%
% 	See also COLORMAP, HOT
%
%	Written by 
%	Valeriy R. Korostyshevskiy, PhD
%	Georgetown University Medical Center
%	Washington, D.C.
%	December 2006
%
% 	vrk@georgetown.edu

% modified by Junjie. Yao, PhD student, 
% adding the Clim to clip the color range
% Check the arguments
% modefied by Junjie. Yao, the second time
% add a second mode for mapping
% mode = 0, map the whole color scale linearly
% mode = 1, map the positive and negative value using two differnt colormap

if nargin<1
	error('grs2rgb:missingImage','Specify the name or the matrix of the image');
end;

if ~exist('map','var') || isempty(map)
	map = hot(256);
end;

[l,w] = size(map);

if w~=3
	error('grs2rgb:wrongColormap','Colormap matrix must contain 3 columns');
end;

if ischar(img)
	a = imread(img);
elseif isnumeric(img)
	a = img;
else
	error('grs2rgb:wrongImageFormat','Image format: must be name or matrix');
end;

% Calculate the indices of the colormap matrix
a = double(a);
if isempty(Clim)
    Clim(1) = min(a(:));
    Clim(2) = max(a(:));
end
if mode == 0
a = (a-Clim(1))/(Clim(2)-Clim(1));
a(a<=0) = 1E-10; % Need to produce nonzero index of the colormap matrix by JJY
ci = ceil(l*a); 
ci(ci>l) = l;
elseif mode == 1 
idx1 = find(a<=0);
idx2 = find(a>0);
a(idx1) = -a(idx1)/Clim(1)/2+1/2;
a(idx2) = a(idx2)/Clim(2)/2+1/2;
a(a<=0) = 1E-10; % Need to produce nonzero index of the colormap matrix by JJY
ci = ceil(l*a); 
ci(ci>l) = l;
end
% Colors in the new image
[il,iw] = size(a);
r = zeros(il,iw); 
g = zeros(il,iw);
b = zeros(il,iw);
r(:) = map(ci,1);
g(:) = map(ci,2);
b(:) = map(ci,3);

% New image
res = zeros(il,iw,3);
res(:,:,1) = r; 
res(:,:,2) = g; 
res(:,:,3) = b;
