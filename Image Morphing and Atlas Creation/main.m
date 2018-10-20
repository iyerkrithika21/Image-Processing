while(1)

clc;
clear all;
close all;
folder=fileparts(which(mfilename));
addpath(genpath(folder));
    
disp('Image Transformations (warping) using Radial Basis Functions');
disp('');
disp('');
disp('');


disp('Image Morphing');
disp('');
disp('');
disp('');

disp('1. Shapes       2. Obama to Bush     3.Batman ');
disp('');
disp('');

i=input('Select Images to be Morphed  : ');
disp('');
disp('');

switch(i)
    case 1
        morphing('params.txt',folder);
    case 2
        morphing('obamabush.txt',folder);
    case 3
        morphing('batmanFinal.txt',folder);
    otherwise
        disp('Selction out of range');
end

disp('');
disp('');
disp('');

disp('Image Atlas creation   : ');
disp('');
disp('');
disp('');

disp('1. Shapes       2. Brain        3.Cars');
disp('');
disp('');


i=input('Select Images for which atlas is to be created  ');
disp('');
disp('');

switch(i)
    case 1
        atlasofimages('shapes_atlas.txt',folder);
    case 2
       atlasofimages('brainatlas.txt',folder);
    case 3
        atlasofimages('carsatlas.txt',folder);
    otherwise
        disp('Selction out of range');
end


choice = menu('Do you want to continue.Press yes no','Yes','No');
if choice==2 | choice==0
   break;
end
end

