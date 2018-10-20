function morphing(filename,folder)

%%Kernel select------------------------------------------------------------
%%-------------------------------------------------------------------------
disp('1.Thin Plate Spine       2.Gaussian');
disp(' ' );
disp(' ' );
kinp=input('Select Kernel type:   ');

%%Get parameters from params.txt-------------------------------------------
%%-------------------------------------------------------------------------
fileID=fopen(filename,'r+');

%%Read the correspondance points-------------------------------------------
CorsPoints = cell2mat(textscan(fileID,'%n %n',...
    'TreatAsEmpty',{'NA','na'},'CommentStyle','//'));
M=CorsPoints(1,1)/2;
N=CorsPoints(1,2);
formats=[];
for(i=1:N)
    formats=[formats '%n'];
end
fclose(fileID);


%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
fileID=fopen(filename,'r+');
CorsPoints1 = cell2mat(textscan(fileID,formats,...
    'TreatAsEmpty',{'NA','na'},'CommentStyle','//'));

fileNam=textscan(fileID,'%s','Delimiter','',...
    'TreatAsEmpty',{'NA','na'},'CommentStyle','//');
fclose(fileID);


%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
CorsPoints1(1,:)=[];

X=CorsPoints1(1:2:2*M,:);
Y=CorsPoints1(2:2:2*M,:);
X1Cords=(X(:,1))';
X2Cords=(X(:,2))';
Y1Cords=(Y(:,1))';
Y2Cords=(Y(:,2))';

%%Other paramters----------------------------------------------------------
%%-------------------------------------------------------------------------
outputI=fileNam{1,1}{N+1,1};
numOfI=str2double(fileNam{1,1}{N+2,1});
sigma=str2double(fileNam{1,1}{N+3,1});

%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

for(i=1:N)
    testImage{i}=[];
    image{i,1}=fileNam{1,1}{i,1};
    testImage{i}=[testImage{i},imread(image{i,1})];
    %%testImage{i}=[testImage{i},histeq(imread(image{i,1}))];
    
end
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
[height1 width1 channel1] = size(testImage{1});
[height2 width2 channel2] = size(testImage{2});


X=X1Cords;
XPrime=X2Cords;

Y=Y1Cords;
YPrime=Y2Cords;

%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

for(t=0:(1/(numOfI-1)):1)
    outputI=fileNam{1,1}{N+1,1};
    output1=[];
    output2=[];
    output=[];
    
    CX=(1-t).*X+t.*XPrime;
    CY=(1-t).*Y+t.*YPrime;
    pixelLoc1=[];
    pixelLoc2=[];
    
    
    parametersF1=rbf_cal(X,Y,CX,CY,kinp,sigma);
    pixelLoc1=forward(X,Y,parametersF1,height1,width1,kinp,sigma);
    minY1=min(pixelLoc1(:,1));
    minX1=min(pixelLoc1(:,2));
    maxY1=max(pixelLoc1(:,1));
    maxX1=max(pixelLoc1(:,2));
    
    parametersF2=rbf_cal(XPrime,YPrime,CX,CY,kinp,sigma);
    pixelLoc2=forward(XPrime,YPrime,parametersF2,height2,width2,kinp,sigma);
    minY2=min(pixelLoc2(:,1));
    minX2=min(pixelLoc2(:,2));
    maxY2=max(pixelLoc2(:,1));
    maxX2=max(pixelLoc2(:,2));
    
    minX=min([minX1 minX2]);
    minY=min([minY1 minY2]);
    maxX=max([maxX1 maxX2]);
    maxY=max([maxY1 maxY2]);
    offsetX=ceil(minX-1);
    offsetY=ceil(minY-1);
    
    canvasX=ceil(maxX-minX)+1;
    canvasY=ceil(maxY-minY)+1;
    
    output1=zeros(canvasX,canvasY,channel1);
    output2=zeros(canvasX,canvasY,channel2);
    output=zeros(canvasX,canvasY,channel1);
    
    parametersR1=rbf_cal(CX,CY,X,Y,kinp,sigma);
    parametersR2=rbf_cal(CX,CY,XPrime,YPrime,kinp,sigma);
    
    output1=reverse(CX,CY,parametersR1,testImage{1},canvasY,canvasX,output1,offsetX,offsetY,kinp,sigma);
    output2=reverse(CX,CY,parametersR2,testImage{2},canvasY,canvasX,output2,offsetX,offsetY,kinp,sigma);
    
    figure
    output=(1-t)*output1+t*output2;
    imshow(uint8(output), []);
    
    addpath(genpath(folder));
    name=strcat(outputI, num2str(t));
    name=strcat(name, num2str(kinp));
    name=strcat(name,'.png');
    
    filename=strcat(folder, '\output\', char(name));
    saveas(gcf,filename);
    
    
    
end


end
