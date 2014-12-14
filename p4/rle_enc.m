% based on Code by Peter J. Acklam
% adapted by S.Schaefer
% function accepts 1D array (column or row vector)
% function returns a vector. The first half contains the values, the 
% second half contains the runlengths.
function data = rle_enc(x)

if size(x,1) > size(x,2), x = x'; end % if x is a column vector, transpose
i = [ find(x(1:end-1) ~= x(2:end)) length(x) ];
data = cat(2, x(i), diff([ 0 i ]));