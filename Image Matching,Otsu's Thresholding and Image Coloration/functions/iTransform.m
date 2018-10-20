function outputImage = iTransform(testImage,imcdf)

[rows cols]=size(testImage);


for(r=1:1:rows)
    for(c=1:1:cols)
        equalizedI(r,c) = imcdf(double(testImage(r,c)+1));
    end
end
outputImage=equalizedI;
end
