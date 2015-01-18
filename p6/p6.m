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
##seperate background using ordered filter##
n = 65; #(35 for min/max, 65 for med)
domain = true (n,n);
%bg_shade = ordfiltn(original, 1, domain, 'symmetric');      #minimum filter
bg_shade = ordfiltn(original, floor(n*n/2) , domain, 'symmetric');  #median filter
%bg_shade = ordfiltn(original, n*n, domain, 'symmetric');  #maximum filter

figure();
imshow(bg_shade);
title('shading image');

#minum: produces artifacts in light parts of the image
#medium: good filtering of background, but doesn't get all objects
#maximum: produces "bounding boxes" in dark part of the image


##test ideas##
###########################################################
#For better results separate the image into three parts to get 
#combine the orderd filters minimum for black backgorund, 
#median for grey and maximum for white.
#Produces bugs(bounding boxes) if contrast doesn't fit the filter
#(as you can see using the maximumfilter)
#solution: interpolation between the results

####following: try to combine the the separated images####
####bg1 - bg3 = 3 different versions of bg_shade(renamed)
%bg = original;
#separation
%o_1 = original-bg1;
%o_2 = imabsdiff(original,bg2);
%o_3 = bg3-original;

#combine them
%bg_3 = uint16(floor(size(bg,2)/3));
%bg(1:size(bg,1),2*bg_3:3*bg_3) = o_3(1:size(bg,1),2*bg_3:3*bg_3);
%bg(1:size(bg,1),bg_3:2*bg_3) = o_2(1:size(bg,1),bg_3:2*bg_3);
%bg(1:size(bg,1),1:bg_3) = o_1(1:size(bg,1),1:bg_3);
%bg = im2bw(bg, 0.05);
############################################################



%4
##separate the background from the foreground, get binary image##
bg = original-bg_shade; #minimum and median filter
%bg = bg_shade-original; #for maximum filter
bg = im2bw(bg, 0.05);

##show segmented image
figure();
imshow(bg);
title('segmentation using ordered filter');


%5
##alternative solution##
##abstract##
#Assumption: all interesting things are peaks
#in the histogram. We delete all grey values that
#are not a peak, because they are not shading artifacts
#and filter the rest of the shading values that are still in the peaks.

#get the histogram
his = imhist(original);

#compute the mean value + std derivation
mn = mean(his) + std(his);

#Delete all values smaller than mean + std.
#So peaks with information are still in histogram.
#Set the grey value of the peak into it's position in the vector.
for i = 1 : size(his)
  if his(i) < mn
    his(i) = 0;
  else 
    his(i) = i-1; #-1 because of zero based grey values
  endif  
end

#trim the vector to keep only peaks
his = his(his~=0);

#set all values in image to 0 that are not peaks
#and all other values(peaks) to 255
segment = ones(size(original));

for i = 1 : size(original,1)
  for j = 1 : size(original,2)
    if original(i,j) != his(:)
      segment(i,j) = 0;
    endif
  end
end

#use minimum filter to delete lines of the peak grey values in bg
n = 3;
domain = true (n,n);
segment = ordfiltn(segment, 1, domain);

##show the segmented image##
figure();
imshow(segment);
title('segmentation by keeping peaks');