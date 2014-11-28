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

%fft original and psf into frequency domain
F = fft2(original);
F = fftshift(F);
H = fft2(h);
H = fftshift(H); 

% inverse filtering 
G = F./H;  

g = ifft2(ifftshift(G));

figure();
imshow(fftshift(g));
title('inverse filtering');
 
#use wienerFilter to correct image, and show, find appropriate value of K
wienie = wienerFilter(F, H, 0.01);
figure();
imshow(wienie);
title('corrected image using wiener filter');

