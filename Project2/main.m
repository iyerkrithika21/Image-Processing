while(1)
clc;
clear all;
close all;

disp('Image colorization');
disp('          ');
disp('          ');
disp('          ');

disp('1. Histogram equalizing transformation      2.Intensity Transformation');   
disp('3.inverse histogram equalization transformation    4.color matching  ');
n=input('Select Function to be called : ');


disp('         ');
disp('          ');

folder=fileparts(which(mfilename));
addpath(genpath(folder));
    
% Selection of the images provided on the project website is provided here

if(n<4)
    disp('Select Image');
    Inum=input('1.Hawkes        2.Shapes Noise      3.Brain MRI     4.Coins     5.Einstein    6.Car : ');
    
    switch(Inum)
        case 1
            testImage=imread('hawkes.jpg');
            
        case 2
            testImage=imread('shapes_noise.jpg');
            
        case 3
            testImage=imread('brain.jpg');
            
        case 4
            testImage=imread('coins.jpg');
            
        case 5
            testImage=imread('einstein.jpg');
        case 6
            testImage=imread('car.png');
            
        otherwise
            disp('Please enter valid Image number');
    end
else
disp('Select Image');
    Inum=input('1.Lake Powell    2.Boardroom     3.Extra1     4.Extra2   ');
    switch(Inum)
        case 1
            testImage1=imread('LakePowell1.jpg');
            testImage2=imread('LakePowell2.jpg');
        case 2
            testImage1=imread('people1.jpg');
            testImage2=imread('people2.jpg');
        case 3
            testImage1=imread('city.png');
            testImage2=imread('LakePowell2.jpg');
        case 4
            testImage1=imread('mountain.jpg');
            testImage2=imread('houndog1.jpg');
         end   
            
         
end


switch(n)
    case 1

        if(size(testImage,3)==3)
            testImage=rgb2gray(testImage);
        end
        imcdf=myhisteq(testImage,folder);
        figure
        plot(imcdf);
        title('Normalised Histogram');
        xlabel('Intensities');
        ylabel('CDF');
        addpath(genpath(folder));
        filename=strcat(folder, '\output\', 'Histogram.jpg');
        saveas(gcf,filename);

    case 2

        if(size(testImage,3)==3)
            testImage=rgb2gray(testImage);
        end
        imcdf=myhisteq(testImage,folder);
        outputImage=iTransform(testImage,imcdf);
        figure
        imshow(uint8(outputImage));
        title('Image obtained after intensity transformation');
        addpath(genpath(folder));
        filename=strcat(folder, '\output\', 'IntensityTransformation.jpg');
        saveas(gcf,filename);

    case 3

        if(size(testImage,3)==3)
            testImage=rgb2gray(testImage);
        end
        Map=inversehistogram(testImage,folder);
        X=['Mapping array is '  num2str(Map)];
        disp(X);
        addpath(genpath(folder));
        filename=strcat(folder, '\output\', 'InverseHistMap.xlsx');
        xlswrite(filename,Map);
    case 4
        
        if(size(testImage1,3)==3)
            testImage1=rgb2gray(testImage1);
        end
        
        
        colour(testImage1,testImage2,folder);
end


disp('          ');
disp('          ');
disp('          ');
disp('Counting cells');
disp('          ');
disp('          ');
disp('          ');

disp('1.Otsu’s thresholding method       2.Adaptive thresholding method');   
disp('3.Cell Counting using Otsu     4.Cell Counting using Adaptive thresholding  ');
n=input('Select Function to be called : ');

if(n==1 || n==2)
    
    disp('Select Image');
    Inum=input('1.Hawkes        2.Shapes Noise      3.Brain MRI     4.Coins     5.Einstein    ');
    
    switch(Inum)
        case 1
            testImage=imread('hawkes.jpg');
            
        case 2
            testImage=imread('shapes_noise.jpg');
            
        case 3
            testImage=imread('brain.jpg');
            
        case 4
            testImage=imread('coins.jpg');
            
        case 5
            testImage=imread('einstein.jpg');
            
        otherwise
            disp('Please enter valid Image number');
    end
end






switch (n)
    case 1

        if(size(testImage,3)==3)
            testImage=rgb2gray(testImage);
        end
        thresImage=otsuThresh(testImage,folder);
    case 2

        if(size(testImage,3)==3)
            testImage=rgb2gray(testImage);
        end
        adaptive_thresh(testImage,folder);
       
    case 3
        testImage=imread('CellImage.tif');
        cellDetectOtsu(testImage,folder);
    case 4
        testImage=imread('CellImage.tif');
        cellDetectAdap(testImage,folder);
end




choice = menu('Do you want to continue.Press yes no','Yes','No');
if choice==2 | choice==0
   break;
end
end
