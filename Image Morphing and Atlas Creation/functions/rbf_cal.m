function parameters=rbf_cal(CX,CY,XT,YT,kinp,sigma)

M=size(CX,2);

for(i=1:1:M)
    for(j=1:1:M)
        diff=norm([CY(j) CX(j)]-[CY(i) CX(i)]);
        if(kinp==1)
                      
            if(diff~=0)
                B(j,i)=diff*diff*log(diff); 
            else
                B(j,i)=0;
            end            
        elseif(kinp==2)
            B(j,i)=(exp(-diff*diff/(2*sigma*sigma)));
        end
        
    end
end
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
L=[CX;CY;ones(1,M)];
K=zeros(3,3);
N=[L K];
M=[B CY' CX' ones(M,1)];
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
SmallB = [N;M];
B=[SmallB zeros(size(SmallB));zeros(size(SmallB)) SmallB];
Binv=pinv(B);
out=[0;0;0;XT';0; 0; 0; YT'];
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
parameters = Binv*out;



end
