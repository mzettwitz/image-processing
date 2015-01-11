

function [filtered_img] = spatial_filter2 (img, kernel)

## the following code just works fine for kernels the size 3x3

# kernel as following : a b c
#                       d e f
#                       g h i


sizeImg = size(img);
# for a

imgA = [zeros(sizeImg(1),2) img];
imgA = [zeros(2,size(imgA,2));imgA];

imgA = imgA .* kernel(1,1);

# for b

imgB = [zeros(sizeImg(1),1) img zeros(sizeImg(1),1)];
imgB = [zeros(2,size(imgB,2)) ; imgB];

imgB = imgB .* kernel(1,2);

# for c

imgC = [img zeros(sizeImg(1),2)];
imgC = [zeros(2,size(imgC,2)) ; imgC];

imgC = imgC .* kernel(1,3);

# for d

imgD = [zeros(sizeImg(1),2) img];
imgD = [zeros(1,size(imgD,2)) ; imgD ; zeros(1,size(imgD,2))];

imgD = imgD .* kernel(2,1);

# for e 

imgE = [zeros(sizeImg(1),1) img zeros(sizeImg(1),1)];
imgE = [zeros(1,size(imgE,2)) ; imgE; zeros(1,size(imgE,2))];

imgE = imgE .* kernel(2,2);

# for f

imgF = [img zeros(sizeImg(1),2)];
imgF = [zeros(1,size(imgF,2)) ; imgF ; zeros(1,size(imgF,2))];

imgF = imgF .* kernel(2,3);

# for g

imgG = [zeros(sizeImg(1),2) img];
imgG = [imgG ; zeros(2,size(imgG,2))];

imgG = imgG .* kernel(3,1);

#for h

imgH = [zeros(sizeImg(1),1) img zeros(sizeImg(1),1)];
imgH = [imgH ; zeros(2,size(imgH,2))];

imgH = imgH .* kernel(3,2);

#for i 
imgI = [img zeros(sizeImg(1),2)];
imgI = [imgI ; zeros(2,size(imgI,2))];

imgI = imgI .* kernel(3,3);

filtered_img = imgA + imgB + imgC + imgD + imgE + imgF + imgG + imgH + imgI;
filtered_img = filtered_img(2:size(filtered_img,1)-1,2:size(filtered_img,2)-1);



endfunction
