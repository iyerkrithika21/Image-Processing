function colour_matching(testImage1,testImage2,folder)


[rows cols]=size(testImage1);
outputImage=zeros(rows,cols,3);


%Gray Image Histogram------------------------------------------------------

histIm1(1:256)=0;


for(r=1:1:rows)
    for(c=1:1:cols)
        x=testImage1(r,c);
        histIm1(x+1)=histIm1(x+1)+1;
    end
end


sum(1)=histIm1(1);
for(i=2:1:256)
    sum(i)=sum(i-1)+histIm1(i);
    
end

Simg1 = floor(255*sum/(rows*cols));

%Histogram of Colour Image-------------------------------------------------
%Red
histIm1(1:256)=0;
[rows cols]=size(testImage2(:,:,1));

for(r=1:1:rows)
    for(c=1:1:cols)
        x=testImage2(r,c,1);
        histIm1(x+1)=histIm1(x+1)+1;
    end
end



sum(1)=histIm1(1);
for(i=2:1:256)
    sum(i)=sum(i-1)+histIm1(i);
    
end

Zimg2R = floor(255*sum/(rows*cols));

%Histogram of Colour Image-------------------------------------------------
%Green
histIm1(1:256)=0;
[rows cols]=size(testImage2(:,:,2));

for(r=1:1:rows)
    for(c=1:1:cols)
        x=testImage2(r,c,2);
        histIm1(x+1)=histIm1(x+1)+1;
    end
end



sum(1)=histIm1(1);
for(i=2:1:256)
    sum(i)=sum(i-1)+histIm1(i);
    
end

Zimg2G = floor(255*sum/(rows*cols));

%Histogram of Colour Image-------------------------------------------------
%Blue

histIm1(1:256)=0;
[rows cols]=size(testImage2(:,:,3));

for(r=1:1:rows)
    for(c=1:1:cols)
        x=testImage2(r,c,3);
        histIm1(x+1)=histIm1(x+1)+1;
    end
end


sum(1)=histIm1(1);
for(i=2:1:256)
    sum(i)=sum(i-1)+histIm1(i);
    
end

Zimg2B = floor(255*sum/(rows*cols));

%Mapping--------------------------------------------------------------------


MapR(1,256)=0;
MapG(1,256)=0;
MapB(1,256)=0;

MapR=iMapping(Simg1,Zimg2R);
outputImage(:,:,1) = iTransform(testImage1,MapR);


MapG=iMapping(Simg1,Zimg2G);
outputImage(:,:,2) = iTransform(testImage1,MapG);

MapB=iMapping(Simg1,Zimg2B);
outputImage(:,:,3) = iTransform(testImage1,MapB);
outputImage=uint8(outputImage);

figure
subplot(1,3,1);
imshow(testImage1);
title('Gray Image to be Coloured');

subplot(1,3,2);
imshow(testImage2);
title('Reference Colour Image');

subplot(1,3,3);
imshow(outputImage);
title('Coloured Image');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'Colouringmatching.jpg');
saveas(gcf,filename);

end
