function [numCorrect, numIncorrect] = testData(images, coefficientVectors, spotsToUse, titlesToUseList, labels, titleNumToCheck)
numCorrect = 0;
numIncorrect = 0;
for imNum = 1:size(images, 2)
   if((getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) > 0) && (labels(imNum) == titlesToUseList(titleNumToCheck)) || (getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) < 0) && (labels(imNum) ~= titlesToUseList(titleNumToCheck)))
      numCorrect = numCorrect + 1;
   elseif((getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) > 0) && (labels(imNum) ~= titlesToUseList(titleNumToCheck)) || (getPercentageMatch(images(:, imNum), coefficientVectors(:, titleNumToCheck), spotsToUse) < 0) && (labels(imNum) == titlesToUseList(titleNumToCheck)))
      numIncorrect = numIncorrect + 1;
   end
end
