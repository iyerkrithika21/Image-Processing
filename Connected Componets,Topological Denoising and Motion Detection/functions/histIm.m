function histIm(testImage,n,minIn,maxIn,folder)


testImage = rgb2gray(testImage);
[rows,cols] = size(testImage);

range_In = (maxIn - minIn);

bin_size = ceil(range_In/n);
%n bins of having size as 'bin_size' are created
x=minIn;
for(i=1:1:n)
    x(i+1)=x(i)+bin_size;
end

%histogram array is initialized to zeros

histbin(size(x,2)) =0;

%HISTOGRAM CALCULATION

    for(r =1 :1:rows)
        
        for(c = 1 : 1: cols)
            
          for i = 1 :1:(size(x,2)-1)
            if (x(i)<= testImage(r,c)) && (testImage(r,c) <x(i+1))
                histbin(i) = histbin(i) +1;
            end
           end
        end
    end
    
%display 
figure(1)
subplot(1,2,1)
bar(x,histbin);
endl=x(n+1);
xlim([0 endl]);
title('Hostogram of Image');
xlabel('Intensities');
ylabel('H');


subplot(1,2,2);
imshow(testImage);
title('Origianl Image');
addpath(genpath(folder));
filename=strcat(folder, '\output\', 'Histogram.jpg');
saveas(gcf,filename);


end










