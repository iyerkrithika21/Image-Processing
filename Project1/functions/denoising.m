function [denoisedImage]=denoising(image_out,denoisedImage,visited,r,c)
[rows cols]=size(image_out);

Q=[r c];
P=[r c];

label=image_out(r,c);
visited(r,c)=label;
C=[];


while(numel(Q)>0)

    a=Q(1,1);
    b=Q(1,2); 
    Q(1,:)=[];
    
   
    
    nbra(1)=a;
    nbra(2)=a+1;
    nbra(3)=a-1;
    nbra(4)=a;
    
    nbrb(1)=b+1;
    nbrb(2)=b;
    nbrb(3)=b;
    nbrb(4)=b-1;
    
    
    for(temp1=1:1:4)
        if(0<nbra(temp1) && nbra(temp1)<=rows)
            if(0<nbrb(temp1) && nbrb(temp1)<=cols)
                if(image_out(nbra(temp1),nbrb(temp1))==label && visited(nbra(temp1),nbrb(temp1))==0)
                    visited(nbra(temp1),nbrb(temp1))=label;
                    Q=[Q;nbra(temp1) nbrb(temp1)];
                    P=[P;nbra(temp1) nbrb(temp1)];
                    
                elseif (image_out(nbra(temp1),nbrb(temp1))~=label)
                    C=[C,image_out(nbra(temp1),nbrb(temp1))];
                end
            end
        end
    end
end   
    Cnt=zeros(1, max(C)+1);

for(k=1:1:size(C,2))
    Cnt(C(k)+1)=Cnt(C(k)+1) + 1;
end



for(m=1:1:size(Cnt,2))
    if(Cnt(m)==max(Cnt))
        labelind=m-1;
        
        
    end
end


for(j=1:1:size(P,1))
        x=P(j,1);
        y=P(j,2);
        denoisedImage(x,y)=labelind;
end





end

