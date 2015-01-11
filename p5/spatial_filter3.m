## Authors: Martin Zettwitz, Michael Groessler
##programming task 5

%1
##abstract
# This function creates nxn images, where n is the size of the kernel
# these are shifted(with a black border -> zero padding), 
# multiplied with the the entry from the filterkernel
# and added to the filtered_img.
# This reduces the computation time a lot, as one only has to use nxn computations
# for the whole image instead of a nxn computations for every pixel.
# At the end the black border is removed as it is not necessary anymore.

## If there are any further questions, please message us, as it is hard to explain without a sketch

##input
#image in spatial domain
#filter kernel(quadric, odd) in spatial domain

##output
#filterd image in spatial domain

function [filtered_img] = spatial_filter3 (img, kernel)

k1 = size(kernel,1)-1;
k2 = size(kernel,2)-1;

#cast image into double values to handle negative values
img = double(img);

#zero padding
filtered_img = zeros(size(img,1) + k1,size(img,2) + k2); 


for rows = 0 : k1
  for cols = 0 : k2
      wobble_img = [zeros(size(img,1),k2-cols) img zeros(size(img,1),cols)];
      wobble_img = [zeros(k1-rows,size(wobble_img,2)); wobble_img ; zeros(rows,size(wobble_img,2))];
      wobble_img = wobble_img .* kernel(rows+1,cols+1);
      filtered_img += wobble_img;
  end
end

filtered_img = double(filtered_img(k1/2+1:size(filtered_img,1)-k1/2,k2/2+1:size(filtered_img,2)-k2/2));

endfunction
