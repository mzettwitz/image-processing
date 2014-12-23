## Copyright (C) 2014 Martin Zettwitz, Michael Größler

%1
##abstract
#funtion to filter a given image(spatial) in the spatial domain
#with a given filter kernel(spatial) that observes the image borders

##input
#image in spatial domain
#filter kernel(quadric, odd) in spatial domain

##output
#filterd image in spatial domain

function [filtered_img] = spatial_filter (img, kernel)

#generate new matrix for the filtered image
filtered_img = zeros(size(img));

#get the size of the kernel(important for borders)
k_size = size(kernel,1);

#loops for rows and cols to convolute with the kernel
for col = 1:size(img,1)     #iterate through columns in original image
  for row = 1:size(img,2)     #iterate through rows in original image
    for inner_cols = (col-floor(k_size/2)) : (col+floor(k_size/2))     #iterate through cols(kernel-based) in original
      for inner_rows = (row-k_size(k_size/2)) : (row+k_size(k_size/2))  #iterate through rows(kernel-based) in original
      
        if isnan(img(inner_cols, inner_rows)) ==  1   #check if kernel based cell is outside the matrix
          filtered_img(col,row) += 0;
        else                                          #else get the value and multiply it with the kernel value/kernel-size^2
          filtered_img(col,row) += img(inner_cols,inner_rows)*(kernel(inner_cols, inner_rows)/(size(kernel,1)*size(kernel,1)));
        end 
        
      end    
    end
  end
end


endfunction
