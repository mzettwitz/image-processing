% Authors: Michael Gr��ler, Martin Zettwitz
% programming task 3

close all;clear;

%get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

%show original image
imshow(original);
title('input image');