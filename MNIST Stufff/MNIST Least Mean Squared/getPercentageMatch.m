function percentageMatch = getPercentageMatch(data, coefficients, spots)
percentageMatch = 0;
coeNum = 0;
for count = 1:size(data,1)
   if (spots(count) == 1)
       coeNum = coeNum + 1;
       percentageMatch = percentageMatch + data(count)*coefficients(coeNum);
   end
end