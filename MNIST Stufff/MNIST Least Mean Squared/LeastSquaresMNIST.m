% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');

%Initialize variables
%Variables that you may want to change
titlesToUseList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
trainingMaxSize = 50000;
testingMaxSize = 10000;

%Set variables, DO NOT TOUCH
spotsToUse = size(images, 1);
numberOfTitles = (size(titlesToUseList, 2));
%Set the number of images to use in the experiement
if (trainingMaxSize > size(images, 2)); imagesToUse = size(images,2) + 1; else; imagesToUse = trainingMaxSize; end
vectorSolutions = zeros((imagesToUse), 1);  %y

%Setup the xMat to only contain the used pixels
for curRow = 1:size(images, 1)
    containsNum = 0;
    for curCol = 1:imagesToUse
        if images(curRow, curCol) ~= 0
           containsNum = 1; 
        end
    end
    spotsToUse(curRow) = containsNum;
end
%initialize xMat
xMat = zeros(size(images, 1), imagesToUse);
%Fill xMat with matrix values
for curRow = 1:size(spotsToUse, 2)
   for curImg = 1:imagesToUse
      if (spotsToUse(1, curRow) == 1)
          xMat(curRow,curImg) = images(curRow,curImg);
      end
   end
end

%Clean xMat
xMat( :, all(~xMat,1) ) = []; %column clean
xMat( all( ~xMat, 2 ), : ) = []; %row clean

%Prepare variables for solving for B
xTranspose = xMat;
xMat = xMat.';
xByXT = (xTranspose*xMat);
xByXTInv = xByXT^-1;
xSimplified = xByXTInv*xTranspose;
coefficientVectors = zeros(size(xMat, 2), numberOfTitles);  %B

% We are using display_network from the autoencoder code
%display_network(images(:,1:100)); % Show the first 100 images
disp(labels(1:10));

%Get the values of the Least Means Square
%For each title solve B = ((X.'*X)^-1)*X.'*y
for currentTitlePos = 1:numberOfTitles
    
    %Find the vector of solutions (y, true or false match)
    for titleToTest = 1:imagesToUse
        %If the titles match, add a 1 to vectorSolutions, else add -1
        if labels(titleToTest, 1) == titlesToUseList(currentTitlePos)
            vectorSolutions(titleToTest) = 1;
        else
            vectorSolutions(titleToTest) = -1;            
        end
    end
    
    %Find the coefficientVectors
    coefficientVectors(:,currentTitlePos) = xSimplified*vectorSolutions;
    disp("Finished title " + currentTitlePos + " of " + numberOfTitles);
    
end

%Find the number that the trained data gets on the test data
correctness = zeros(size(titlesToUseList, 2), 1);
incorrectness = zeros(size(titlesToUseList, 2), 1);
for titleNumToCheck = 1:size(titlesToUseList, 2)
    [correctness(titleNumToCheck), incorrectness(titleNumToCheck)] = testData(images(:,trainingMaxSize:(testingMaxSize+trainingMaxSize)), coefficientVectors, spotsToUse, titlesToUseList, labels, titleNumToCheck);
end


%Test out individual image against all nine
mostLikelyNum = zeros(testingMaxSize, 1);
outOfAllCorrect = 0;
outOfAllIncorrect = 0;
for imageToTest = trainingMaxSize:trainingMaxSize+testingMaxSize
    mostLikelyNum(imageToTest-trainingMaxSize+1) = getMostLikelyNum(images(:, imageToTest), coefficientVectors, spotsToUse, titlesToUseList);
    if(titlesToUseList(mostLikelyNum(imageToTest-trainingMaxSize+1)) == labels(imageToTest))
        outOfAllCorrect = outOfAllCorrect + 1;
    else
        outOfAllIncorrect = outOfAllIncorrect + 1;
    end
    disp("It guessed " + titlesToUseList(mostLikelyNum(imageToTest-trainingMaxSize+1)) + ", the correct label is " + labels(imageToTest));
end





% numCorrect = 0;
% numIncorrect = 0;
% titleNumToCheck = 1;
% for imNum = trainingMaxSize:(testingMaxSize+trainingMaxSize)
%    if((getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) > 0) && (labels(imNum) == titlesToUseList(titleNumToCheck)) || (getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) < 0) && (labels(imNum) ~= titlesToUseList(titleNumToCheck)))
%       numCorrect = numCorrect + 1;
%    elseif((getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) > 0) && (labels(imNum) ~= titlesToUseList(titleNumToCheck)) || (getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) < 0) && (labels(imNum) == titlesToUseList(titleNumToCheck)))
%       numIncorrect = numIncorrect + 1;
%    end
% end


