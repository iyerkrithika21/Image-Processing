 function Map = iMapping(Simg,Zimg)

Map(1,256)=0;

for(i=1:1:256)
    diff=abs(Simg(i)-Zimg);
    [value,indx]=min(diff);
    Map(i)=indx-1;
end
end
