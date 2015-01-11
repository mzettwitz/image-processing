## Copyright (C) 2015 KingCotton
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} spatial_filter3 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: KingCotton <kingcotton@kingcottonPC>
## Created: 2015-01-11

function [filtered_img] = spatial_filter3 (img, kernel)

k1 = size(kernel,1)-1;
k2 = size(kernel,2)-1;

filtered_img = zeros(size(img,1) + k1,size(img,2) + k2);
 


for rows = 0 : k1
  for cols = 0 : k2
      wobble_img = [zeros(size(img,1),k2-cols) img zeros(size(img,1),cols)];
      wobble_img = [zeros(k1-rows,size(wobble_img,2)); wobble_img ; zeros(rows,size(wobble_img,2))];
      wobble_img = wobble_img .* kernel(rows+1,cols+1);
      filtered_img += wobble_img;
  end
end

filtered_img = filtered_img(k1/2+1:size(filtered_img,1)-k1/2,k2/2+1:size(filtered_img,2)-k2/2);

endfunction
