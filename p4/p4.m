## Authors: Michael Groessler, Martin Zettwitz
## programming task : 4

close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
figure('Name','Input Image','NumberTitle','off');
imshow(original);


##2.seperate imag into M x M blocks(8|16)
m =[8 16];

# m(1) = 8 , m(2) = 16
#create vectors of blocksize needed for mat2cell
rows8 = ones(1,size(original,1)/m(1)) * m(1);
cols8 = ones(1,size(original,2)/m(1)) * m(1);

rows16 = ones(1,size(original,1)/m(2)) * m(2);
cols16 = ones(1,size(original,2)/m(2)) * m(2);

#create blocks
b8Image = mat2cell(original,rows8,cols8);
b16Image = mat2cell(original,rows16,cols16);

##3.DCT into frequency domain
dct8Image = cellFunction(b8Image,@dct2);
dct16Image = cellFunction(b16Image,@dct2);

##4.quantization of frequencies
load('quantm.mat');

quant8Image = cellFunction(dct8Image,@(x)  round(x ./quant8));
quant16Image = cellFunction(dct16Image,@(x) round(x ./ quant16));

##5.sort data(zig-zag) and encode them with run-length
rle8Image = cellFunction(cellFunction(quant8Image,@zigzag),@rle_enc);
rle16Image = cellFunction(cellFunction(quant16Image,@zigzag),@rle_enc);

#calculate compressionrate
#use number entries in original image(pixels) compared to entries in rle version
#each entry represents the length of the according cell,
#adding them up gives us the size of the particular cell
rle8mat = cell2mat(cellFunction(rle8Image,@length));
rle16mat = cell2mat(cellFunction(rle16Image,@length));

rle8Size = sum(rle8mat(:));
rle16Size = sum(rle16mat(:));
originalSize = size(original,1) * size(original,2);

comp8Rate = originalSize/rle8Size;
comp16Rate = originalSize/rle16Size;

##6.revert the last steps and transform into spatial domain

re8Image = cellFunction(cellFunction(rle8Image,@rle_dec),@zagzig);
re16Image = cellFunction(cellFunction(rle16Image,@rle_dec),@zagzig);

deQuant8Image = cellFunction(re8Image,@(x) x .* quant8);
deQuant16Image = cellFunction(re16Image,@(x) x .* quant16);

idct8Image = cellFunction(deQuant8Image,@idct2);
idct16Image = cellFunction(deQuant16Image,@idct2);

comp8Image = cell2mat(idct8Image);
comp16Image = cell2mat(idct16Image);

#7.show results for 8 and 16 blocks, show compression rate

figure('Name','M = 8','NumberTitle','off');
imshow(comp8Image,[]);
title(['Compressionrate = ' num2str(comp8Rate)]);

figure('Name','M = 16','NumberTitle','off');
imshow(comp16Image,[]);
title(['Compressionrate = ' num2str(comp16Rate)]);
#answer to last question
#(what are differences between block sizes and different pictures, why?)



#M = 8
#Das Bild ist kontrastschwaecher als das Originalbild oder das M = 16 Bild
#
#M = 16
#Dieses Bild weisst keine groﬂe Veraenderung zum Original auf, 
#Aenderungen sind nur zu erkennen, wenn man ranzoomt
#
#Die hoehere Kompressionsrate und die schlechtere Qualitaet des M = 8 Bildes
#stehen im Zusammenhang mit der gewaehlten Quantisierungsmatrix. Da durch 
#diese staerker quantisiert wird und mehr Werte zu 0 gesetzt werden, ist
#das Bild dementsprechend schlechter.
#Fuer M = 16 sind die Quantisierungskoeffizienten relativ klein, so dass
#viele Frequenzen nahe des Mittelpunkts beibehalten werden. Dadurch sinkt
#natuerlich die Kompressionsrate. Allerdings bleibt die Bildqualitaet gut erhalten.
#

