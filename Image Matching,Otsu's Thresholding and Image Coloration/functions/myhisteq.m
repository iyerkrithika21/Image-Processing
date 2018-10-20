function imcdf=myhisteq(testImage,folder)

L=256;
histIm(1:L)=0;
[rows cols]=size(testImage);

for(r=1:1:rows)
    for(c=1:1:cols)
        x=testImage(r,c);
        histIm(x+1)=histIm(x+1)+1;
    end
end

figure
subplot(1,2,1);
imshow(testImage);
title('Original Image');

subplot(1,2,2);
x=1:1:256;
stem(x,histIm);
title('Histogram of Original Image');
xlabel('Intensities');
ylabel('Frequency of Occurrence');

addpath(genpath(folder));
filename=strcat(folder, '\output\', 'Histogram_1.jpg');
saveas(gcf,filename);
sum(1)=histIm(1);
for(i=2:1:L)
    sum(i)=sum(i-1)+histIm(i);
    
end

imcdf = floor((L-1)*sum/(rows*cols));


end
