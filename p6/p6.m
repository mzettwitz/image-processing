## Authors: Martin Zettwitz, Michael Groessler
## programming task : 6

close all;clear;

%1
##get image##
[filename, pathname] = uigetfile('*.*' , 'Select image');
original = imread([pathname '/' filename]);
clear pathname filename;

##show original image##
figure('Name','Input Image','NumberTitle','off');
imshow(original,[]);
title('original image');

%2
##show histogram##
figure();
imhist(original);
title('original histogram');

##concluson##
#Interesiting things (foregound) create peaks,
#the other 248 shades of grey are nearly equally distributed 
#over the whole histogram, so we don't have a bimodal histogram.

%3
##seperate background using median filter
n = 3;
dom = true (n,n);
%bg1 = ordfiltn(original, 1, dom);
%bg2 = ordfiltn(original, n*n/2, dom);
bg3 = ordfiltn(original, n*n, dom);
%bg = original;
%o_1 = original-bg1;
%o_2 = imabsdiff(original,bg3);
%o_3 = bg3-original;
%bg_3 = uint16(floor(size(bg,2)/3));
%bg(1:size(bg,1),2*bg_3:3*bg_3) = o_3(1:size(bg,1),2*bg_3:3*bg_3);
%bg(1:size(bg,1),bg_3:2*bg_3) = o_2(1:size(bg,1),bg_3:2*bg_3);
%bg(1:size(bg,1),1:bg_3) = o_1(1:size(bg,1),1:bg_3);

%4
bg = bg3-original;
%bg = im2bw(bg, graythresh(bg));


##show background
figure();
imshow(bg, []);
title('background by using median filter');

%5
##alternative
#get the histogram
his = imhist(original);

#compute the mean value * 1.25
mn = mean(his)*2;

#delete all values smaller than mean*1.25
#so peaks with information are still in histogram
#set the grey value of the peak into it's position
sgm = ones(size(original));
for i = 1 : size(his)
  if his(i) < mn
    his(i) = 0;
  else 
    his(i) = i-1;
  endif  
end

#trim the array to keep only peaks
his = his(his~=0);

#set all values in image to 0 that are not peaks
#and all other values(peaks) to 255
for i =1:size(original,1)
  for j = 1:size(original,2)
    if original(i,j) != his(:)
      sgm(i,j) = 0;
    endif
  end
end

#use minimum filter to delete lines
n = 3;
dom = true (n,n);
sgm = ordfiltn(sgm, 1, dom);


figure();
imshow(sgm);