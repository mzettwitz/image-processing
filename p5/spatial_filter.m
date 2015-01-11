## Copyright (C) 2014 Martin Zettwitz, Michael Groessler

%1
##abstract
#funtion to filter a given image(spatial) in the spatial domain
#with a given filter kernel(spatial) that observes the image borders (zero padding)

##input
#image in spatial domain
#filter kernel(quadric, odd) in spatial domain

##output
#filterd image in spatial domain

function [filtered_img] = spatial_filter (img, kernel)

img = double(img);

#generate new matrix for the filtered image
filtered_img = zeros(size(img));

#get the size of the kernel(important for borders)
k_size = size(kernel,1);
k_size2 = floor(k_size/2);

#loops for rows and cols to convolute with the kernel
for col = 1:size(img,1)    #iterate through columns in original image
  for row = 1:size(img,2)     #iterate through rows in original image
    for inner_cols = (-k_size2) : (k_size2)    #iterate through cols(kernel-based) in original
      for inner_rows = (-k_size2) : (k_size2)  #iterate through rows(kernel-based) in original
      
        #check if kernel based cell is outside the matrix (then 0)
        if (col+inner_cols < 1 | col+inner_cols > size(img,1) | row+inner_rows < 1 | row+inner_rows > size(img,2))   
          filtered_img(col,row) += 0;
        else       #else get the value and multiply it with the kernel value/kernelsize^2
                   #inner_cols + k_size - k_size2 to fit the negative inner_cols value into the kernel
          filtered_img(col,row) += (img(col+inner_cols,row+inner_rows)*kernel(inner_cols+k_size-k_size2, inner_rows+k_size-k_size2))/(k_size*k_size);
        end 
        
      end    
    end
  end
end

filtered_img = filtered_img;

endfunction
