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
m =[8 16];

#used for 'Uniformoutput'
uni = 'Uniformoutput'
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
dct8Image = cellfun(@dct2,b8Image, uni, false);
dct16Image = cellfun(@dct2,b16Image, uni, false);
#4.quantization of frequencies
load('quantm.mat');

quant8Image = cellfun(@(x)  round(x ./quant8) , dct8Image, uni, false);
quant16Image = cellfun(@(x) round(x ./ quant16), dct16Image, uni, false);
#5.sort data(zig-zag) and encode them with run-length

rle8Image = cellfun(@rle_enc,(cellfun(@zigzag, quant8Image, uni, false)),uni, false);
rle16Image = cellfun(@rle_enc,(cellfun(@zigzag, quant16Image, uni, false)),uni, false);

#calculate compressionrate


#6.reverse the last steps and transform into spatial domain

re8Image = cellfun(@zagzig,(cellfun(@rle_dec,rle8Image, uni,false)),uni,false);
re16Image = cellfun(@zagzig,(cellfun(@rle_dec,rle16Image, uni,false)),uni,false);

deQuant8Image = cellfun(@(x) x .* quant8 , re8Image, 'Uniformoutput', false);
deQuant16Image = cellfun(@(x) x .* quant16 , re16Image, 'Uniformoutput', false);

idct8Image = cellfun(@idct2,deQuant8Image, 'Uniformoutput', false);
idct16Image = cellfun(@idct2,deQuant16Image, 'Uniformoutput', false);

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
