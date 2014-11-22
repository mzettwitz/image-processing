## Authors: Michael Größler, Martin Zettwitz
## programming task 3

close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
imshow(original);
title('input image');

#generate PSF








#fft image and psf, reduce error



#show corrected image 

 
#use wienerFilter to correct image, and show, find appropriate value of K


