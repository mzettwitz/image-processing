## Authors: Michael Größler, Martin Zettwitz
## programming task 4

close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
imshow(original);
title('input image');

#2.seperate imag into M x M blocks(8|16)

#3.DCT into frequency domain

#4.quantization of frequencies

#5.sort data(zig-zag) and encode them with run-length

#6.reverse the last steps and transform into spatial domain

#7.show results for 8 and 16 blocks, show compression rate

#answer to last question
#(what are differences between block sizes and different pictures, why?)
