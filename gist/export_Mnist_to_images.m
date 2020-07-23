%change the MNIST image data to gist data

%load MNIST dataset
clc;clear all;
newSubFolder = './mnist_img/';

load MNIST
data = dataset.x;
label = dataset.y;
database = [data label];

[sortedLabels, index] = sort(label);
dataInclass = database(index,:);
clear database;
numPerClass = 7000;

if ~exist(newSubFolder, 'dir')
  mkdir(newSubFolder);
end

for i = 1:numPerClass*10
    image = data(i,:);
    img = reshape(image,28,28);
    imageName = [newSubFolder, num2str(i), '.jpg'];
    imwrite(img, imageName, 'jpg');
    fprintf('%d image\n', i);
end
