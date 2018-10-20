function cellDetectAdap(testImage,folder)



n=input('Enter the block size: ');
mvar=input('Enter the minimum variance value : ');
[rows cols]=size(testImage);

a= mod(n,2);
if(a>0)
    exa=(n-1)/2;
else
    exa=n/2;
end

ypadding= zeros(rows,exa);
testImage1 = [ypadding testImage ypadding];
xpadding = zeros(exa,(cols+2*exa));
testImage = [xpadding;testImage1;xpadding];

[rows cols]=size(testImage);

figure
subplot(1,2,1);
imshow(testImage);
title('Original Image');

targetImage(rows,cols)=0;
 meanX=0;
for(r=1:n:rows-n)
    for(c=1:n:cols-n)
        x=0;
       
        for(i=r:1:r+n-1)
            for(j=c:1:c+n-1)
                x(i,j)=testImage(i,j);
            end
        end
        
        meanX=sum(sum(x))/(n*n);
        
        varX=0;
         for(i=r:1:r+n-1)
            for(j=c:1:c+n-1)
                varX=varX+((x(i,j)-meanX)^2)/(n*n);
            end
         end
         
         if(varX>mvar)
             threshold=meanX+(sqrt(varX));
        
             
            for(i=r:1:r+n-1)
                for(j=c:1:c+n-1)
                    if(testImage(i,j)>threshold)
                        targetImage(i,j)=1;
                    else
                        targetImage(i,j)=0;
                    end
                end
            end
         end
         
    end
end
                        
                        
           
         
    
subplot(1,2,2);
imshow(targetImage);  
title('Thresholded Image');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'AdapCellThresh.jpg');
saveas(gcf,filename);

% targetImage=median(targetImage,[3 3]);
topodenoising(targetImage,folder);
end
