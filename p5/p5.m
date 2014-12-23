## Authors: Martin Zettwitz, Michael Größler
## programming task : 5

#close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
figure('Name','Input Image','NumberTitle','off');
imshow(original,[]);

#filter collection
smooth3 = ones(3,3);
smooth3 *= 0.9;

smooth5 = ones(5,5);
smooth5 *= 0.9;

edge3 = zeros(3,3);
edge3(1,2) = 1;
edge3(2,1:2:3) = 1;
edge3(2,2) = -4;
edge3(3,2) = 1;

#edge_sobel = [1,-2,1];


%2
#test own implemented spatial filter with a smoothing filter 
#and an edge filter, use different sizes for the filter kernel
#smooth_im3 = spatial_filter(original, smooth3);
#smooth_im5 = spatial_filter(original, smooth5);
#edge_im3 = spatial_filter(original, edge3);
#edge_imsobel = spatial_filter(original, edge_sobel);

#show spatial filterd images
#figure();
#imshow(smooth_im3,[]);
#title('spatial-smooth-3');

#figure();
#imshow(smooth_im5,[]);
#title('spatial-smooth-5');

#figure();
#imshow(edge_im3,[]);
#title('spatial-edge-3');

#figure();
#imshow(edge_imsobel, []);
#title('spatial-edge-sobel-1d');


%4
#test filters in frequency domain
smooth_im3_f = frequency_filter(original,smooth3);

#show frequency filtered images
figure();
imshow(abs(log(smooth_im3_f)),[]);
title('frequency-smooth-3');

#compute the differences in the pictures

#show differences 

#explain differences


%5
#measure the computation time of both methods 
#how does the kernel size effects the computation time?


%additional task
#compute and return a binomial filter using exc. 1
