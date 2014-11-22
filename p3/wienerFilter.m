##Author: Michael Größler, Martin Zettwitz

function corImg = wienerFilter (errImg, PSF)

#F(u,v) = ((H(u,v)^2/(H(u,v)*(|H(u,v)|^2+K))))*G(u,v)
#where F is our corrected image
#H is our fft PSF
#G is our error proned image

corImg = zeros(size(errImg,1),size(errImg,2));



endfunction
