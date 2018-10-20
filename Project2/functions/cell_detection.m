clc;
clear all;
close all;

testImage=imread('CellImage.tif');
%testImage=mat2gray(testImage);
% testImage=double(rgb2gray(testImage));
[rows cols]=size(testImage);


testImage=double(testImage);
minIn=min(min(testImage));
maxIn=max(max(testImage));
TI = testImage-minIn;
TI = TI/maxIn;
TI = TI*255;
testImage=uint8(TI);

myhist(1:256)=0;
for r=1:1:rows
    for c=1:1:cols
        x=testImage(r,c);
        myhist(x+1)=myhist(x+1)+1;
    end
end

figure(5)
plot(myhist);

normHist= floor(myhist/(rows*cols));

pk1(1)=normHist(1);
temp=0;
for(i=2:1:256)
    temp=temp+normHist(i);
end
pk2(1)=temp;
for(i=2:1:256)
    
    pk1(i)=normHist(i)+pk1(i-1);
    if(i==256)
        pk2(i)=normHist(i);
    else
        temp=normHist(i+1);
        for(j=i+2:1:256)
            temp=normHist(j)+temp;
        end
        pk2(i)=temp;
    end
end

    

mk1(1)=normHist(1);

temp=0;
for(i=2:1:256)
    temp=temp+i*normHist(i);
end
mk2(1)=temp;

for(i=2:1:256)
    
    mk1(i)=i*normHist(i)+mk1(i-1);
    if(i==256)
        mk2(i)=normHist(i);
    else
        temp=(i+1)*normHist(i+1);
        for(j=i+2:1:256)
            temp=j*normHist(j)+temp;
        end
        mk2(i)=temp;
    end
end


for(i=1:1:256)
    if(pk1(i)==0)
        mk1(i)=0;
    else
        mk1(i)=mk1(i)/pk1(i);
        
    end
    if(pk2(i)==0)
        mk2(i)=0;
    else
        mk2(i)=mk2(i)/pk2(i);
    end
      
end


for(i=1:1:256)
    sigmab(i)=pk1(i)*pk2(i)*((mk1(i)-mk2(i))^2);
end

[value k]=max(sigmab);


for(r=1:1:rows)
    for(c=1:1:cols)
        if(testImage(r,c)<k)
            threshImage(r,c)=0;
        else
            threshImage(r,c)=1;
        end
    end
end

figure(2)
imshow((threshImage));
image_out(rows,cols)=0;
label=3;

% L = medfilt2(threshImage,[3 3]);
% figure, imshow(L)
topodenoising(threshImage)



