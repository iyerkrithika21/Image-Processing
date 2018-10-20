function atlasofimages(filename,folder)

%%Kernel select------------------------------------------------------------
%%-------------------------------------------------------------------------
disp('1.Thin Plate Spine       2.Gaussian');
disp(' ' );
disp(' ' );
kinp=input('Select Kernel type:   ');
%%-------------------------------------------------------------------------

%%Get parameters from params.txt-------------------------------------------
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

%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

fileID=fopen(filename,'r+');   
CorsPoints1 = cell2mat(textscan(fileID,formats,...
'TreatAsEmpty',{'NA','na'},'CommentStyle','//'));

fileNam=textscan(fileID,'%s','Delimiter','',...
'TreatAsEmpty',{'NA','na'},'CommentStyle','//');
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------


CorsPoints1(1,:)=[];

XCords=CorsPoints1(1:2:2*M,:);
YCords=CorsPoints1(2:2:2*M,:);

for(i=1:1:N)
    X(i,:)=(XCords(:,i)');
    Y(i,:)=(YCords(:,i)');
end

%%other parameters---------------------------------------------------------
outputI=fileNam{1,1}{N+1,1};
sigma=str2double(fileNam{1,1}{N+2,1});

%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

for(i=1:N)
    testImage{i}=[];
    image{i,1}=fileNam{1,1}{i,1};
    testImage{i}=[testImage{i},imread(image{i,1})]; 
   %%testImage{i}=[testImage{i},histeq(imread(image{i,1}))]; 
    
end
%%-------------------------------------------------------------------------
%%CX and CY calculations---------------------------------------------------

X1=X;
Y1=Y;
CX=zeros(1,M);
CY=zeros(1,M);

for(i=1:1:N)
    CX=CX+X1(i,:);
    CY=CY+Y1(i,:);
end

CX=CX/N;
CY=CY/N;
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

F=[];
R=[];
pixelLoc=[];


%%Forward transform--------------------------------------------------------
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

for(i=1:1:N)
    F(i,:)=rbf_cal(X1(i,:),Y1(i,:),CX,CY,kinp,sigma);
    pixelLoc(:,:,i)=forward(X1(i,:),Y1(i,:),F(i,:),size(testImage{i},1),size(testImage{i},2),kinp,sigma);  
end

%%Calculation of canvas size and offset
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------

for(i=1:1:N)
    maxXLoc(i,:)=max(pixelLoc(:,2,i));
    minXLoc(i,:)=min(pixelLoc(:,2,i));
    maxYLoc(i,:)=max(pixelLoc(:,1,i));
    minYLoc(i,:)=min(pixelLoc(:,1,i));
end

maxX=max(maxXLoc);
minX=min(minXLoc);

maxY=max(maxYLoc);
minY=min(minYLoc);

offsetX=ceil(minX-1);
offsetY=ceil(minY-1);
canvasX=ceil(maxX-minX);
canvasY=ceil(maxY-minY);
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------




%%Reverse transformation to get the pixel intensities----------------------
%%-------------------------------------------------------------------------

for(i=1:1:N)
    [h w channels]=size(testImage{i});
    output=zeros(canvasX,canvasY,channels);
    
    R(i,:)=rbf_cal(CX,CY,X1(i,:),Y1(i,:),kinp,sigma);
    atlas(:,:,:,i)=reverse(CX,CY,R(i,:),testImage{i},canvasY,canvasX,output,offsetX,offsetY,kinp,sigma);
end

%%-------------------------------------------------------------------------

%%Atlas creation by adding all the outputs from reverse transformation-----
%%-------------------------------------------------------------------------
outputimage=zeros(canvasX,canvasY,channels);

for(i=1:1:N)
    outputimage=outputimage+atlas(:,:,:,i);
end

outputimage=outputimage./N;

%%Display and save---------------------------------------------------------
%%-------------------------------------------------------------------------
figure
imshow(uint8(outputimage));
addpath(genpath(folder));

filename=strcat(folder, '\output\', outputI);
saveas(gcf,filename);



end
