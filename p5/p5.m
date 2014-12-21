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


%2
#test own implemented spatial filter with a smoothing filter 
#and an edge filter, use different sizes for the filter kernel

#show spatial filterd images


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
