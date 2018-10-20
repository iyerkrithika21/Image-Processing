function [pixelLoc]=forward(cx,cy,k,out_height,out_width,kinp,sigma)

pixelLoc=[];
N = size(cx,2);

%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
for j=1:out_height
    for i=1:out_width
       
        y = j ;
        x = i ;
        outputPixLoc = [0 0];
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
        
       
        outputPixLoc(1) = outputPixLoc(1) + k(N+1) * x + k(N+2) * y + k(N+3);
        outputPixLoc(2) = outputPixLoc(2) + k(N+N+4) * x + k(N+N+5) * y + k(N+N+6);
        
        [pixelLoc] = [pixelLoc;[outputPixLoc(2) outputPixLoc(1)]];
        
        
    end
end


end
