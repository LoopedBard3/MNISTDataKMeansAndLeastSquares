function vectors = getVectorsOfTitle(matrixSet, titles, titleToFind)

%Initialize variables
counter = 0;
vectors = zeros(size(matrixSet));

%For each title, add matching matrix spots to vectors
for curTitlePoint = 1:size(titles, 1)
    if titles(curTitlePoint, 1) == titleToFind
        counter = counter + 1;
        vectors(:, counter) = matrixSet(:,curTitlePoint);
    end
end

%Remove all columns consisting of only zero
vectors( :, all(~vectors,1) ) = [];

disp("Vector for title " + titleToFind + " found.");