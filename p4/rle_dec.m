% based on Code by Peter J. Acklam
% adapted by S.Schaefer
% function accepts 1D array (column or row vector). The first half must
% contain the values and the second half must contain the run lengths.
% function returns 1D array (row vector) with the original code.
function data = rle_dec(x)
if size(x,1) > size(x,2), x = x'; end % if x is a column vector, transpose
v = x(1: size(x, 2)/2);
r = x((size(x,2)/2)+1:size(x,2));

i = cumsum([ 1 r ]);
j = zeros(1, i(end)-1);
j(i(1:end-1)) = 1;
data = v(cumsum(j));

