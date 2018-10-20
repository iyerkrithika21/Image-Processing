function [image_out pixelcc]=floodFilltp(image_in,image_out,r,c,label,pixelValue)
[rows,cols]=size(image_in);
 pixelcc=1;
% Structure similar to queue is maintained to keep a account of all the
% neighbours
Q=[r c]; 

image_out(r,c)=label;

while(numel(Q)>0)

    %the first element of the queue is checked for all the members and the
    %value is removed from the queue
    a=Q(1,1);
    b=Q(1,2); 
    Q(1,:)=[];
    
   %all the 4 connected neighbours are checked
    
    nba(1)=a;
    nba(2)=a+1;
    nba(3)=a-1;
    nba(4)=a;
    
    nbb(1)=b+1;
    nbb(2)=b;
    nbb(3)=b;
    nbb(4)=b-1;
    
    %checking if all the pixels have the same label as that of the seed
    %pixel
    for(temp1=1:1:4)
        if(0<nba(temp1) && nba(temp1)<=rows)
            if(0<nbb(temp1) && nbb(temp1)<=cols)
                if(image_in(nba(temp1),nbb(temp1))==pixelValue && image_out(nba(temp1),nbb(temp1))==0)
                    image_out(nba(temp1),nbb(temp1))=label;
                    Q=[Q;nba(temp1) nbb(temp1)];
                    pixelcc=pixelcc+1;
                    
                end
            end
        end
    end
    


end
end








