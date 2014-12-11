## Authors: Michael Groessler, Martin Zettwitz
## programming task : 4

close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
imshow(original);
title('input image');

#2.seperate imag into M x M blocks(8|16)
m =[8 16];

# m(1) = 8 , m(2) = 16
#create vectors of blocksize needed for mat2cell
rows8 = ones(1,size(original,1)/m(1)) * m(1);
cols8 = ones(1,size(original,2)/m(1)) * m(1);

rows16 = ones(1,size(original,1)/m(2)) * m(2);
cols16 = ones(1,size(original,2)/m(2)) * m(2);

#blocksize of 8 x 8
b8Image = mat2cell(original,rows8,cols8);

#blocksize of 16x16
b16Image = mat2cell(original,rows16,cols16);
#3.DCT into frequency domain
dct8Image = cellFunction(b8Image,@dct2);
dct16Image = cellFunction(b16Image,@dct2);
#4.quantization of frequencies
load('quantm.mat');

quant8Image = cellFunction(dct8Image,@(x)  round(x ./quant8));
quant16Image = cellFunction(dct16Image,@(x) round(x ./ quant16));
#5.sort data(zig-zag) and encode them with run-length

rle8Image = cellFunction(cellFunction(quant8Image,@zigzag),@rle_enc);
rle16Image = cellFunction(cellFunction(quant16Image,@zigzag),@rle_enc);
#calculate compressionrate


#6.reverse the last steps and transform into spatial domain

re8Image = cellFunction(cellFunction(rle8Image,@rle_dec),@zagzig);
re16Image = cellFunction(cellFunction(rle16Image,@rle_dec),@zagzig);

deQuant8Image = cellFunction(re8Image,@(x) x .* quant8);
deQuant16Image = cellFunction(re16Image,@(x) x .* quant16);

idct8Image = cellFunction(deQuant8Image,@idct2);
idct16Image = cellFunction(deQuant16Image,@idct2);

komp8Image = cell2mat(idct8Image);
komp16Image = cell2mat(idct16Image);
#7.show results for 8 and 16 blocks, show compression rate

figure;
imshow(komp8Image,[]);
title(['M = 8 ']);

figure;
imshow(komp16Image,[]);
title(['M = 16 ']);
#answer to last question
#(what are differences between block sizes and different pictures, why?)
