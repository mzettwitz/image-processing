% function to solve task 5
% reads input image(frequency domain)
% copies values of x,y into new matrix
% finally the new matrix gets re-transformed into spatial domain  

function B = fft5 (img,x,y)

%create matrix the size of img loaded
help = zeros(size(img,1),size(img,2));

%shift wanted indices to center
x = x + size(img,1)/2;
y = y + size(img,2)/2;

%set pixel
help(x,y) = img(x,y);

%re-transform B and return it
B = help;
B = ifft2(ifftshift(B));

endfunction
