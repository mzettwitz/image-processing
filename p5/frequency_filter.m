## Copyright (C) 2014 Martin Zettwitz, Michael Größler

%3
##abstract
#funtion to filter a given image in the frequency domain
#with a given filter kernel(spatial) that has to be transformed
#in the frequency domain and observes the image borders

##input
#image in spatial domain
#filter kernel(quadric, odd) in spatial domain

##output
#filterd image in spatial domain

function [filtered_img] = frequency_filter (img, kernel)

#transform kernel into mask
mask = zeros(size(img));
k_size = size(kernel,1);
k_size2 = floor(k_size/2);
img_mid_x = floor(size(img,1)/2);   #center of x values
img_mid_y = floor(size(img,2)/2);   #center of y values

for col = (-k_size2):(k_size2)      #iterate through kernel size
  for row = (-k_size2):(k_size2)    #iterate through kernel size
    #put the values of the kernel into the center of the mask
    #col+k_size-k_size2 to fit the negative col value into the kernel
    mask(img_mid_x+col,img_mid_y+row) = kernel(col+k_size-k_size2, row+k_size-k_size2); 
  end
end

#transform into frequency domain
img_f = fft2(img);
mask_f = fft2(mask);

######WHY THE FUCK DOES THIS WORK AS WELL###
%#transform kernel into mask
%mask = zeros(size(img));
%mask(1:3,1:3) = kernel;
%figure();
%imshow(mask);

#multiply image and filtermask
filtered_img = img_f.*mask_f;

#return shifted and transformed image
filtered_img  = ifftshift(ifft2(filtered_img));

endfunction
