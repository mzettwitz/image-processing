## Authors: Martin Zettwitz, Michael Größler
## programming task : 5

close all;clear;

#get image
[filename, pathname] = uigetfile('*.bmp', 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

#show original image
figure('Name','Input Image','NumberTitle','off');
imshow(original,[]);

#filter collection
smooth3 = ones(3,3);
smooth3 *= 0.9;

smooth5 = ones(5,5);
smooth5 *= 0.9;

edge3 = ones(3,3);
edge3 *= -1;
edge3(2,2) = 8;

edge_sobel = [-1,2,-1];


%2
#test own implemented spatial filter with a smoothing filter 
#and an edge filter, use different sizes for the filter kernel
tic();
smooth_im3 = spatial_filter(original, smooth3);
smooth3_t = toc();

tic();
smooth_im5 = spatial_filter(original, smooth5);
smooth5_t = toc();

edge_im3 = spatial_filter(original, edge3);
edge_imsobel = spatial_filter(double(original), edge_sobel);

#show spatial filterd images
figure();
imshow(smooth_im3,[]);
title('spatial-smooth-3');

figure();
imshow(smooth_im5,[]);
title('spatial-smooth-5');

figure();
imshow(edge_im3,[]);
title('spatial-edge-3');

figure();
imshow(edge_imsobel, []);
title('spatial-edge-sobel-1d');


%4
#test filters in frequency domain
tic();
smooth_im3_f = frequency_filter(original,smooth3);
smooth3f_t = toc();

tic();
smooth_im5_f = frequency_filter(original,smooth5);
smooth5f_t = toc();

edge_im3_f = frequency_filter(original, edge3);
edge_imsobel_f = frequency_filter(original, edge_sobel);

#show frequency filtered images
figure();
imshow(smooth_im3_f,[]);
title('frequency-smooth-3');

figure();
imshow(smooth_im5_f,[]);
title('frequency-smooth-5');

figure();
imshow(edge_im3_f,[]);
title('frequency-edge-3');

figure();
imshow(edge_imsobel_f,[]);
title('frequency-edge-sobel-1d');

#compute the differences in the pictures
diff_smooth3 = smooth_im3 - smooth_im3_f;
diff_smooth5 = smooth_im5 - smooth_im5_f;
diff_edge3 = abs(edge_im3 - edge_im3_f);

#show differences 
figure();
imshow(diff_smooth3,[]);
title('diff smooth3');

figure();
imshow(diff_smooth5,[]);
title('diff smooth5');

figure();
imshow(diff_edge3,[]);
title('diff edge3');

#explain differences
#The differences are addicted to the image borders. The borders
#have to bee seen as an individual problem of the spatial method.
#Additionally the filters are susceptible to noise in the image.
#A special in the differences is addicted to our implementation of
#of the spatial filter, which translates the image a little bit.
#So the difference will show the whole image :(

%5
#measure the computation time of both methods 
#how does the kernel size effects the computation time?
difference_between_frequency_smooth3_5 = smooth5f_t - smooth3f_t
difference_between_spatial_smooth3_5 = smooth5_t - smooth3_t
diff_spatial_freq_3 = smooth3_t - smooth3f_t
diff_spatial_freq_5 = smooth5_t - smooth5f_t

#The spatial method is much slower than the frequency One.
#This effect is addicted to the image size and the kernel size 
#(and specially to our crappy implementation).
#The bigger the kernel the bigger is the advantage of the frequency method.
#If you are using a small resoluted image, the spatial method will
#be faster, because of the expensive FFT(excepted our crappy implementation).


%additional task
#compute and return a binomial filter using exc. 1
bino_matrix = bino_filter(3);
bino_im3 = spatial_filter(original, bino_matrix);

figure();
imshow(bino_im3,[]);
title('spatial filter binomial 3x3');
