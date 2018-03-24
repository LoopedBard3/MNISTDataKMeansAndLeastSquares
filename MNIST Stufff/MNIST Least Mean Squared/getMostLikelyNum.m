function mostLikelyNum = getMostLikelyNum(image, coefficientVectors, spotsToUse, titlesToUseList)
    percentages = zeros(size(titlesToUseList, 2), 1);
    for titleNumToCheck = 1:size(titlesToUseList, 2)
        percentages(titleNumToCheck) = getPercentageMatch(image, coefficientVectors(:, titleNumToCheck), spotsToUse);
    end
    [~,mostLikelyNum] = max(percentages(:));
    