% EXAMPLE 1
clc;clear all;

% addpath('./mnist_img/');
load('Fasion2k_cell');
% X = fea;
% Y = gnd;
% Load image
% I = cell(1,70000);
gistdata = zeros(length(Y), 256);

for i = 1 : length(Y)
%     imageName = strcat(num2str(i),'.jpg');
    img = X{i};%imread(imageName);


    % Parameters:
    clear param 
    %param.imageSize. If we do not specify the image size, the function LMgist
    %   will use the current image size. If we specify a size, the function will
    %   resize and crop the input to match the specified size. This is better when
    %   trying to compute image similarities.
    param.orientationsPerScale = [4 4 4 4];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;

    % Computing gist requires 1) prefilter image, 2) filter image and collect
    % output energies
    [gist, param] = LMgist(img, '', param);
    % Visualization
    %figure
    %subplot(121)
    %imshow(img2)
    %title('Input image')
    %subplot(122)
    gistdata(i,:) = gist;    
    fprintf('the %d iter is finished.\n', i);
end

% % fprintf('\nfinished....\n');

% save 'gist_512d_MNIST' gistdata
X = gistdata;
save Fasion2k_gist X Y
