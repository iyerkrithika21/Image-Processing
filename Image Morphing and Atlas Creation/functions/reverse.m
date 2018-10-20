function [output]=reverse(cx,cy,k,I,out_height,out_width,output,offsetX,offsetY,kinp,sigma)


[height width channels] = size( I );
N = size(cx,2);

for j=1:out_height
    for i=1:out_width
        
        y = j+offsetY;
        x = i+offsetX;      
        
        outputPixLoc=[0 0];
        
        for n=1:N
            diff = norm( [y x] - [cy(n) cx(n)] );
            if(kinp==1)
                if ( diff ~= 0 )
                    kernel = diff * diff * log(diff);
                else
                    kernel = 0;
                end
                
            elseif(kinp==2)
                kernel =(exp(-diff*diff/(2*sigma*sigma)));
            end
            
            outputPixLoc(1) = outputPixLoc(1) + k(n) * kernel;
            outputPixLoc(2) = outputPixLoc(2) + k(n+N+3) * kernel;
        end
        
        
        x1 = outputPixLoc(1) + k(N+1) * x + k(N+2) * y + k(N+3);
        y1 = outputPixLoc(2) + k(N+N+4) * x + k(N+N+5) * y + k(N+N+6);
        
        
        if (( y1 <(height) && y1 >=1) && (x1 <(width) && x1 >=1))
            P=bilinear(x1,y1,height,width,I);
            
            output(i,j,:)=P;
            
            
        end
    
        
        
    end
end
end