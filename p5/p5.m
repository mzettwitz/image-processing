## Authors: Martin Zettwitz, Michael Größler
## programming task : 5

#close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
figure('Name','Input Image','NumberTitle','off');
imshow(original);

#filter collection
smooth3 = zeros(3,3);
smooth3 = smooth3 * 0.9;

edge3 = zeros(3,3);
edge3(1,2) = 1;
edge3(2,1:2:3) = 1;
edge3(2,2) = -4;
edge3(3,2) = 1;


%2
#test own implemented spatial filter with a smoothing filter 
#and an edge filter, use different sizes for the filter kernel
smooth = spatial_filter(original, smooth3);


#show spatial filterd images
figure();
imshow(smooth,[]);

%4
#test filters in frequency domain

#show frequency filtered images

#compute the differences in the pictures

#show differences 

#explain differences


%5
#measure the computation time of both methods 
#how does the kernel size effects the computation time?


%additional task
#compute and return a binomial filter using exc. 1
