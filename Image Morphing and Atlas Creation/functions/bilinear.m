function [P]=bilinear(x,y,height,width,I)


            
            x2=ceil(x);
            y2=ceil(y);
            
            
            x1=floor(x);
            y1=floor(y);
            
          
            
%             if(x1<1)
%                 x1=1;
%                 if(x2<=x1)
%                     x2=x1+1;
%                 end
%             end
%             
%             if(x2>=width)
%                 x2=width;
%                 if(x2==x1)
%                     x1=x2-1;
%                 end
%             end
%             
% %             if(x2<=x1)
% %                 x2=x1+1;
% %             end
%             
%             if(y1<1)
%                 y1=1;
%                 if(y2<=y1)
%                     y2=y1+1;
%                 end
%             end
%                     
%             
%             if(y2>=height)
%                 y2=height;
%                 if(y2==y1)
%                     y1=y2-1;
%                 end
%             end
%             
% %             if(y2<=y1)
% %                 y2=y1+1;
% %             end
%             
            
            q11=I(y1,x1,:);
            q21=I(y1,x2,:);
            q12=I(y2,x1,:);
            q22=I(y2,x2,:);
            
            R1=q11.*(x2-x)/(x2-x1)+q21.*(x-x1)/(x2-x1);
            R2=q12.*(x2-x)/(x2-x1)+q22.*(x-x1)/(x2-x1);
            
            if(x1-x2==0||y1-y2==0)
                P=I(round(y),round(x),:);
            else
                P=R1.*(y2-y)/(y2-y1)+R2.*(y-y1)/(y2-y1);
                
            
            
            


end
