function threshImage=otsuThresh(testImage,folder)
figure
subplot(1,2,1);
imshow(testImage);
title('Original Image');
[rows cols]=size(testImage);

if(isa(testImage,'uint16'))
    maxIn=2^16;
else
    maxIn=256;
end

%P1 and P2 calculation---------------------------------------------------
myhist(1:maxIn+1)=0;
for r=1:1:rows
    for c=1:1:cols
        x=testImage(r,c);
        myhist(x+1)=myhist(x+1)+1;
    end
end


normHist= (myhist/(rows*cols));

pk1(1)=normHist(1);
temp=0;
for(i=2:1:maxIn)
    temp=temp+normHist(i);
end
pk2(1)=temp;
for(i=2:1:maxIn)
    
    pk1(i)=normHist(i)+pk1(i-1);
    if(i==maxIn)
        pk2(i)=normHist(i);
    else
        temp=normHist(i+1);
        for(j=i+2:1:maxIn)
            temp=normHist(j)+temp;
        end
        pk2(i)=temp;
    end
end

    
%M1 and M2 calculation-----------------------------------------------------
mk1(1)=0.*normHist(1);

temp=0;
for(i=2:1:maxIn)
    temp=temp+(i-1)*normHist(i);
end
mk2(1)=temp;

for(i=2:1:maxIn)
    
    mk1(i)=(i-1)*normHist(i)+mk1(i-1);
    if(i==maxIn)
        mk2(i)=255*normHist(i);
    else
        temp=(i)*normHist(i+1);
        for(j=i+2:1:maxIn)
            temp=(j-1)*normHist(j)+temp;
        end
        mk2(i)=temp;
    end
end


for(i=1:1:maxIn)
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

%Sigma/Variance Calculation------------------------------------------------
for(i=1:1:maxIn)
    sigmab(i)=pk1(i)*pk2(i)*((mk1(i)-mk2(i))^2);
end

%Get the index of sigma which has the maximum variance---------------------
[~, k]=max(sigmab);

%Thresholding with the value which gave maximum variance-------------------
for(r=1:1:rows)
    for(c=1:1:cols)
        if(testImage(r,c)<k)
            threshImage(r,c)=0;
        else
            threshImage(r,c)=1;
        end
    end
end


subplot(1,2,2);
imshow(threshImage);
title('Thresholded Image');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'OtsuThresholding.jpg');
saveas(gcf,filename);
end
