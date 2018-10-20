function motiondetection(folder)

%this program is hard coded to read the hound dog images. If required the
%new test images can be given here

testImage1 = rgb2gray(imread('houndog1.jpg'));
testImage2 = rgb2gray(imread('houndog2.jpg'));

figure(1)
subplot(1,2,1);
imshow(testImage1);
subplot(1,2,2);
imshow(testImage2);
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'MotionDetection1.jpg');
saveas(gcf,filename);

%difference of the two images is calculated used imabsdiff
testImage=imabsdiff(testImage1,testImage2);
[rows,cols] = size(testImage);

%topological denoising begins here for the subtracted image

%THRESHOLDIN
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

%CONNECTED COMPONENT ANALYSIS
%floodfill 
image_out(rows,cols)=0;
image_in=tholdImage;
pixelx=[];
pixely=[];

label1= input('Enter the label value:  ');

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

denoisedImage=image_out;
visited(rows,cols)=0;

%DENOISING

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
title('Original after Subtraction Image');

subplot(1,3,2);
imagesc(image_out);
title('Flood FIlled');

subplot(1,3,3);
imagesc(denoisedImage);
title('Denoised');

addpath(genpath(folder));
filename=strcat(folder, '\output\', 'MotionDetection2.jpg');
saveas(gcf,filename);

end








