% function to solve task 4, own implementation of Fourier Transform
% input image(spatial domain) gets Fourier transformed into 
% frequency domain

function fftimg = myfft2 (img)
%create matrix the size of image loaded
fftimg = zeros(size(img,1),size(img,2));
%create one dimensional matrix, 'vertical'
imgs = complex(img(:).',0);

%rows, cols used to create matrix of exp^-i2pi(um/M+vn/N)
rows = 1:size(img,1);
cols = rows.';

%need two loops for every (u,v) pair, 
for u = 1:size(img,1)
  for v = 1:size(img,2)
  %exponential is the matrix created for the exp^-i ... , as
  %rows, cols are created like followin( 1,2,3,4,5,6,...,256)
  %these entries are manipulated in the following expression
  %each entry of rows is the 'm', each entry of cols is the 'n'
  %used in ft 
  %arrayfun uses the aftergoing expression for every entry of the matrix passed to it
    exponential = (arrayfun(@(x) exp(-2 * i * pi * (u * x / size(fftimg,1))),cols)) * (arrayfun(@(x) exp(-2 * i * pi *(v * x / size(fftimg,2))),rows));
  %as we created a 1 x size(img,1)*size(img,2) matrix from our image and a 
  %size(img,1)*size(img,2) x 1 matrix from our exponentials needed
  %every (u,v) pixel from our ft is a multiplication of those matrices
    fftimg(u,v) = imgs * (exponential(:));
  end
end
endfunction


%to eliminate the last two loops, a creation of two special matrices is needed
%the first is acquired by using the original image, converting it two 1x size*size
%matrices and concatenating these u-times

%the second matrix is just built like the exponential , but v-times, with some
%indexshifting accordingly to u,v
%should be possible to use u-exponential on first matrix, ARRAYFUN!