##Authors: Michael Groessler, Martin Zettwitz
##programming task : 4

#just to shorten expression of cellfun
function result = cellFunction (img, f = @func)

result = cellfun(f,img,'Uniformoutput',false);

endfunction
