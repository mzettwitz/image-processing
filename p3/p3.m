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
h = psf(original, 11);
figure();
imshow(h);
title('psf');

#transform image and psf
F = fft2(fftshift(original));
H = fft2(fftshift(h));

%inverse image and psf
G = F./H;

%transform new image g into spatial room and show it
g = ifftshift(ifft2(G));

#show corrected image 
figure();
imshow(g);
title('fft image and psf');
 
#use wienerFilter to correct image, and show, find appropriate value of K


