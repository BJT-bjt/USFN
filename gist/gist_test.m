% EXAMPLE 1
% Load image (this image is not square)

addpath('F:\Hashing\YuanYong\gistdescriptor');
img = imread('.\gist_mnist\mnist_img\1.jpg');  %填写你的文件路径

% Parameters:
clear param 
%param.imageSize. If we do not specify the image size, the function LMgist
%   will use the current image size. If we specify a size, the function will
%   resize and crop the input to match the specified size. This is better when
%   trying to compute image similarities.
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Computing gist requires 1) prefilter image, 2) filter image and collect
% output energies
[gist, param] = LMgist(img, '', param);

% Visualization
figure
subplot(121)
imshow(img)
title('Input image')
subplot(122)
showGist(gist, param)
title('Descriptor')




