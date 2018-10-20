function topodenoising(testImage,folder)
[rows,cols] = size(testImage);

tholdImage=testImage;




%CONNECTED COMPONENT ANALYSIS
%floodfill is called for the thresholded image
image_out(rows,cols)=0;
image_in=tholdImage;
%seed values
pixelx=[];
pixely=[];

label1= 3;

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
count=0;
for(i=1:1:size(pixelCount,2))
    if pixelCount(i)<100
        r=pixelx(i);
        c=pixely(i);
        count=count+1;
        denoisedImage=denoising(image_out,denoisedImage,visited,r,c);

    end
end

%display     
figure
subplot(1,3,1);
imagesc(testImage);
title('Original Image');

subplot(1,3,2);
imagesc(image_out);
title('Flood FIlled');

subplot(1,3,3);
imagesc(denoisedImage);
title('Denoised');

disp('Number of cells');
disp(numel(pixelx)-count);

addpath(genpath(folder));
filename=strcat(folder, '\output\', 'CellDenoise.jpg');
saveas(gcf,filename);

end










