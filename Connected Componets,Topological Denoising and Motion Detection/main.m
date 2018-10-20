clc;
clear all;
close all;
 

disp('Enter which operation is to be performed          ');
op=input('1.Histogram     2.Connected Component Analysis    3.Topological Denoising     4.Motion Detection    ');

folder=fileparts(which(mfilename));
    addpath(genpath(folder));
    
%Selection of the images provided on the project website is provided here

if(op>0 && op<=3)
    disp('Select Image');
    Inum=input('1.Turkeys        2.Shapes Noise      3.Brain MRI     4.Coins     ');

    switch(Inum)
    case 1
        testImage=imread('turkeys.jpg');
        [rows,cols]=size(testImage);
        
    case 2
        testImage=imread('shapes_noise.jpg');
        [rows,cols]=size(testImage);
       
    case 3
        testImage=imread('brain.jpg');
        [rows,cols]=size(testImage);
     
    case 4
        testImage=imread('coins.jpg');
        [rows,cols]=size(testImage);
            
        
    otherwise
        disp('Please enter valid Image number');
    end
end

if(op==1)
    %HISTOGRAM 
    minIn=input('Enter the minimum pixel intensity');
    maxIn=input('Enter the maximum pixel intensity');
    n=input('Enter number of bins');
    histIm(testImage,n,minIn,maxIn,folder);      
elseif(op==2)
    %CONNECTED COMPONENT ANALYSIS
    image_out=zeros(rows,cols);
    label=input('Enter Label value : ');
    connectedcomp(testImage,image_out,label,folder);    
elseif(op==3)
    %DENOISING
    topodenoising(testImage,folder);
elseif(op==4)
    %MOTION DETECTION
    motiondetection(folder);
else
        disp('Please enter valid operation to be performed');
end





        
        
        
        
    





        

        