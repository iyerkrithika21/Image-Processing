function Map=inversehistogram(testImage,folder)


%--------------------------------------------------------------------------
%Histogram of input image
%--------------------------------------------------------------------------
L=256;
histIm(1:L)=0;
[rows cols]=size(testImage);

for(r=1:1:rows)
    for(c=1:1:cols)
        x=testImage(r,c);
        histIm(x+1)=histIm(x+1)+1;
    end
end


sum(1)=histIm(1);
for(i=2:1:L)
    sum(i)=sum(i-1)+histIm(i);
    
end

imcdf1 = floor((L-1)*sum/(rows*cols));


%--------------------------------------------------------------------------
%intensity transformation
%--------------------------------------------------------------------------





for(r=1:1:rows)
    for(c=1:1:cols)
        equalizedI(r,c) = imcdf1(double(testImage(r,c)+1));
    end
end
%--------------------------------------------------------------------------
%histohram of other image
%--------------------------------------------------------------------------

L=256;
histIm(1:L)=0;
[rows cols]=size(equalizedI);

for(r=1:1:rows)
    for(c=1:1:cols)
        x=equalizedI(r,c);
        histIm(x+1)=histIm(x+1)+1;
    end
end


sum(1)=histIm(1);
for(i=2:1:L)
    sum(i)=sum(i-1)+histIm(i);
    
end

imcdf2 = floor((L-1)*sum/(rows*cols));


%--------------------------------------------------------------------------
%inverse mapping
%--------------------------------------------------------------------------



Map(1,256)=0;

for(i=1:1:256)
    diff=abs(imcdf2(i)-imcdf1);
    [value,indx]=min(diff);
    Map(i)=indx-1;
end


%--------------------------------------------------------------------------
%intensity transformation check to see whether inverse is correct
%--------------------------------------------------------------------------


for(r=1:1:rows)
    for(c=1:1:cols)
        outputImage(r,c) = Map(double(equalizedI(r,c)+1));
    end
end
figure
subplot(1,3,1);
imshow(uint8(testImage));
title('Original Image');

subplot(1,3,2);
imshow(uint8(equalizedI));
title('Equalised Image');

subplot(1,3,3);
imshow(uint8(outputImage));
title('Output of Inverse Histogram Equalisation');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'Inverse.jpg');
saveas(gcf,filename);
end
