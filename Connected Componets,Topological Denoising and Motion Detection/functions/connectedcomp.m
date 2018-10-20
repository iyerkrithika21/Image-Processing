function connectedcomp(testImage,image_out,label,folder)
testImage=rgb2gray(testImage);
[rows,cols] = size(testImage);
thold1 = input('Enter the first threshold value "thold" :  ');
thold2 = input('Enter the second threshold value "thold2" greater than "thold1" :  ');
tholdImage=testImage;


%THRESHOLDING
%if pixel intensity falls between the threshold 1 is assgined otherwise 0

for (r=1:1:rows)
    for(c=1:1:cols)
        
        if(thold1<=testImage(r,c) && testImage(r,c)<= thold2)
            tholdImage(r,c)=1;
        else
            tholdImage(r,c)=0;
        
        end
    end
end

%display
figure(1)
subplot(1,2,1);
imshow(testImage);
title('Original Image');

subplot(1,2,2);
imagesc(tholdImage);
title('Thresholded Image');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'ConnectedComp1.jpg');
saveas(gcf,filename);

%output image is initialized to zeros

image_out(rows,cols)=0;

image_in=tholdImage;
%pixelx and pixely are the seed points
pixelx=[];
pixely=[];
pixelCount=[];

for(r=1:1:rows)
    for(c=1:1:cols)
       
        if image_in(r,c)==1 && image_out(r,c)==0
            
            pixelValue=1;
            %flood fill algorithim is called for the seed values r and c
            %and 'label' value is assgined to the connected components
            [image_out pixelcc]=floodFilltp(image_in,image_out,r,c,label,pixelValue);
            pixelx=[pixelx,r];
            pixely=[pixely,c];
            pixelCount=[pixelCount,pixelcc];
            
            label=label+1;        
            
            end
    end       
end        

%display
figure(2)
subplot(1,2,1)
imagesc(testImage);
title('Original Image');

subplot(1,2,2);
imagesc(image_out);
title('Flood FIlled');
xlim([1 cols]);

addpath(genpath(folder));
filename=strcat(folder, '\output\', 'ConnectedComp2.jpg');
saveas(gcf,filename);


end



















