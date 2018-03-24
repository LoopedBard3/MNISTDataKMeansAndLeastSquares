for k = 1:centersCounter
    imageNum = k;
    holderArray = zeros(sqrt(size(centers, 1)), sqrt(size(centers, 1)));
    for i = 1:sqrt(size(centers, 1))
        for j = 1:sqrt(size(centers,1))
            holderArray(i,mod(j, 28)+1) = centers((i-1)*28 + j, k);
        end
    end
    im = image(holderArray,'CDataMapping', 'scaled');
    imname = "image" + imageNum + ".png";
    saveas(im, imname, 'png');
    
end