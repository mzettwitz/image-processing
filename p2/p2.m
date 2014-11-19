% Authors: Michael Größler, Martin Zettwitz
% programming task 2

close all;clear;

%get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

%show original image
imshow(original);
title('input image');

%use matlab function to ft and shift it
matlabfft = fft2(original);
fftshifted = fftshift(matlabfft);

%show shifted
figure;
imshow(log(fftshifted),[]);
title('fouriertransformation');

%own fourier transformation
figure;
ownfft = myfft2(original);
ownfft = fftshift(ownfft);
imshow(log(ownfft),[]);
title('own fft');

%task 6
% TODO: complete with subimage -> not implemented in image package yet
% We've looked for the developer version of the package,
% but even there it's not listed in the index
figure;
imshow([fft5(fftshifted,2,6), fft5(fftshifted,-2,-6), 
fft5(fftshifted,2,-6), fft5(fftshifted,14,-3)], []);

%task 7, looks weird 
figure;
imshow(filter(fftshifted,18),[]);
