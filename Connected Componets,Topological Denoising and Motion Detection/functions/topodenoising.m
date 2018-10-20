function topodenoising(testImage,folder)

testImage=rgb2gray(testImage);
[rows,cols] = size(testImage);

%THRESHOLDING

thold1 = input('Enter the first threshold value "thold" :  ');
thold2 = input('Enter the second threshold value "thold2" greater than "thold1" :  ');
tholdImage=testImage;

%pixel value that fall between 0 and thold one are labeled 0
%pixel values that fall between thold1 and thold2 are labelled 1
%pixel values that fall beyond thold2 are labelled 2


for (r=1:1:rows)
    for(c=1:1:cols)
        if(testImage(r,c)<thold1)
             tholdImage(r,c)=0;
        else
            if(thold1<=testImage(r,c) && testImage(r,c)<= thold2)
            tholdImage(r,c)=1;
        else
            tholdImage(r,c)=2;
            end
        end
    end
end

figure(1)
subplot(1,2,1);
imshow(testImage);
title('Original Image');

subplot(1,2,2);
imagesc(tholdImage);
title('Thresholded Image');

addpath(genpath(folder));
filename=strcat(folder, '\output\', 'TopologicalDenoising1.jpg');
saveas(gcf,filename);

%CONNECTED COMPONENT ANALYSIS
%floodfill is called for the thresholded image
image_out(rows,cols)=0;
image_in=tholdImage;
%seed values
pixelx=[];
pixely=[];

label1= input('Enter the label value:  ');

%array to hold the number of pixels in each connected component
pixelCount=[];

for(r=1:1:rows)
    for(c=1:1:cols)
       
        if image_in(r,c)==1 && image_out(r,c)==0
            
            pixelValue=1;
            [image_out pixelcc]=floodFilltp(image_in,image_out,r,c,label1,pixelValue);
            pixelx=[pixelx,r];
            pixely=[pixely,c];
            pixelCount=[pixelCount,pixelcc];
            
            label1=label1+1;
            
        elseif image_in(r,c)==2 && image_out(r,c)==0
                pixelValue=2;
                [image_out pixelcc]=floodFilltp(image_in,image_out,r,c,label1,pixelValue);
                
                pixelx=[pixelx,r];
                pixely=[pixely,c];
                pixelCount=[pixelCount,pixelcc];
                
                label1=label1+1;
            
            
            end
        end
        
        
end

%DENOISING 

denoisedImage=image_out;

%an image with same size as input is intialized to zero to keep a check if
%all pixels are visited
visited(rows,cols)=0;

for(i=1:1:size(pixelCount,2))
    if pixelCount(i)<20
        r=pixelx(i);
        c=pixely(i);
        denoisedImage=denoising(image_out,denoisedImage,visited,r,c);

    end
end

%display     
figure(2)
subplot(1,3,1);
imagesc(testImage);
title('Original Image');

subplot(1,3,2);
imagesc(image_out);
title('Flood FIlled');

subplot(1,3,3);
imagesc(denoisedImage);
title('Denoised');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'TopologicalDenoising2.jpg');
saveas(gcf,filename);

end










