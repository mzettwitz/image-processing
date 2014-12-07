## Authors: Martin Zettwitz, Michael Größler
## programming task 3

close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
imshow(original);
title('input image');

#generate and show PSF --> line with 11 pixels in 45°
h = psf(original, 11);
figure();
imshow(h);
title('psf');

%fft original and psf into frequency domain
F = fftshift(fft2(original));
H = fftshift(fft2(h));

% use inverse filtering to correct motion blur
% inverse filtering and transform into spatial domain
G = F./H;  
g = ifftshift(ifft2(G));

% show inverse filtering --> distortion because of noise
% noise ist translated(moved) by PSF --> distortion
figure();
imshow(abs(g),[]);
title('inverse filtering');
 
#use wienerFilter to correct image, find appropriate value of K
%k = very small(0.000001) --> noise similiar to inverse filtering
%k = too small(0.00001) --> noisy image
%k = too large(1) --> blurred image with ghosting effects(k = 0.9)
%k = very large(100) --> hardly blurred
wienie = wienerFilter(F, H, 0.01); %best practice for k

%show corrected image
figure();
imshow(abs(wienie),[]);
title('corrected image using wiener filter');

