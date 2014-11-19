%Bildverarbeitung WS14/14, Programmieraufgabe 1
%author = Martin Zettwitz, 203201

%interactice dialogue to load imagefile
%[orig] = imread(uigetfile());
[orig] = imread('p1.bmp');

%show image 
imshow(orig); 

%print information
printf("Image height: ");
size(orig, 1)
printf("Image width: " );
size(orig, 2)
printf("Minimal grayscale: ");
min(orig(:))  %(:) for all elementes of all dimensions
printf("Maximal grayscale: ");
max(orig(:))
printf("Average grayscale: ");
mean(orig(:))
printf("Standard deviation of grayscale: ");
std(orig(:))

%copy image to correct mistakes
[pic] = orig;

%...wasn't able to find easy way with transpose of matrix or reshape into vector, 
%because of hangover after party, so here is the dumb way ;)

%correct black pixels 344,219 <> 344,269
%adjust to the pixel error above(white pixels)
for i = 344:size(pic, 1)-1
  for j = 1:size(pic, 2)
    %clear black pixels and move the next pixels
    if(j > 219 && j <= 269)
      pic(i, j) = orig(i, j+50);
    %insert the pixels from left side(end)
    elseif(j > 269 && j <= size(pic, 2))
      pic(i, j) = orig(i+1, j-269);
    %move pixels left to edge (till old black line)
    elseif(j > 100 && j <= 219)
      pic(i, j) = orig(i+1, j+50);
    %move the left part to the border
    else
    pic(i, j) = orig(i+1, j+50);
    endif
  end
end

%correct white pixels 102,65 <> 102,165
for i = 102:size(pic,1)-1
  for j = 1:size(pic, 2)
    %move to the left border
    if(j < 65)  
      pic(i, j) = pic(i+1, (j+100));
    %clear white pixels and move next
    elseif(j >= 65 && j <= 165)   
      pic(i, j) = pic(i, j+100);
    %move the last part right to the center
    elseif(j > 165 && j <= size(pic, 2)-100) 
      pic(i, j) = pic(i+1, j+100);
    %copy left part to the right border
    else
      pic(i, j) = pic(i+1, j-size(pic, 2)+100); 
    endif
  end
end

%show corrected image in a new window
figure(2);
imshow(pic);

%user input of two points from the image
printf("Click on two points inside the image to zoom in\n");

[x,y] = ginput(1);
p1 = [x,y]

[x,y] = ginput(1);
p2 = [x,y]

%copy selected elements(y1->y2, x1->x2)
[zoom] = pic(uint16(p1(2)):uint16(p2(2)), uint16(p1(1)):uint16(p2(1))); 

%scale image by factor 2
zoom = imresize(zoom, 2);

%show zoomed image
figure(3);
imshow(zoom);

%generate histogram
zoom = reshape(zoom,1,[]);
myhis = zeros(1, 256);

%iterate through image and increment the value in histogram  
for i = 1:size(zoom, 2)
  myhis(zoom(i)) = myhis(zoom(i)) + 1;
end

%show histogram
figure(4);
imhist(zoom)

%show my histogram
figure(5);
bar(myhis)
clear;





