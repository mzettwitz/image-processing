##Author: Michael Größler, Martin Zettwitz

function corImg = wienerFilter (errImg, PSF, K)

#F(u,v) = ((H(u,v)^2/(H(u,v)*(|H(u,v)|^2+K))))*G(u,v)
#where F is our corrected image
#H is our fft PSF
#G is our error proned image

corImg = zeros(size(errImg,1),size(errImg,2));

#easy but slow calculation, 
for u= 1:size(corImg,1)
  for v = 1:size(corImg,2)
    corImg(u,v) += errImg(u,v) * ((PSF(u,v)^2)/(PSF(u,v)*(abs(PSF(u,v))^2 + K)));
  end
end

endfunction
