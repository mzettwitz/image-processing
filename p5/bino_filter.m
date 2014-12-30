## Copyright (C) 2014 Martin Zettwitz, Michael Größler

%additional task
##abstract
#funtion to compute a binomial filter matrix of a given size

##input
#1-dimensional size of the matrix

##output
#2-dimenional binomial matrix


function [bino_matrix] = bino_filter (size)

#get a vector representation of the binomial coefficients
bino_vec = zeros(1,size);
for k = 0 : size-1
  bino_vec(k+1) = nchoosek(size-1, k);
end

#compute the matrix by multiplying the vector with it's tansposed form
bino_matrix = bino_vec.' * bino_vec;

endfunction
