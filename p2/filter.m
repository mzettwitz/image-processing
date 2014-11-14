## Copyright (C) 2014 Micha
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
## @deftypefn {Function File} {@var{retval} =} filter (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Micha <Micha@KINGCOTTON>
## Created: 2014-11-12

function B = filter (A,radius)

B = zeros(size(A,1),size(A,2));

%go from 1 to radius ,+ 2 for safety
%use fft5 to get each pixel in radius
for u = (-radius-2):(radius+2)
  for v = (-radius-2):(radius+2)
    if (sqrt(u*u + v*v) < radius)
      B = B + fft5(A,u,v);
    end
  end
end

endfunction
