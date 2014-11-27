## Author: Martin Zettwitz, Michael Größler

## Function to compute and return a PSF matrix

function [h] = psf (original_image, distance)

  h = zeros(size(original_image));
 
  mid_x = floor((size(original_image,1)+1)/2);
  mid_y = floor((size(original_image,2)+1)/2);
 
  h(mid_x, mid_y) = 1;
 
  for i = 1:int16(distance-1)
    h(mid_x+i, mid_y-i) = 1;
  end

endfunction
