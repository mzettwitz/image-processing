##Author: Michael Größler, Martin Zettwitz

function corImg = wienerFilter (G, H, K)

#F'(u,v) = ((|H(u,v)|²)/(H(u,v)*(|H(u,v)|²+K)))*G(u,v)
#where F' is our corrected image,
#H is our fft PSF,
#G is our error proned image

corImg = zeros(size(G));

#easy, but slow calculation 
for u= 1:size(corImg,1)
  for v = 1:size(corImg,2)
    corImg(u,v) = G(u,v) * ((abs(H(u,v))^2)/(H(u,v)*(abs(H(u,v))^2 + K)));
  end
end
corImg = ifftshift(ifft2(corImg));

endfunction
