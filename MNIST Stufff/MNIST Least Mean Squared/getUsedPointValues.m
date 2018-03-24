function vector = getUsedPointValues(isUsed, data)
vector = size(data);
for row = 1:size(data, 1)
   if (isUsed(row) == 1)
       vector(row) = data(row);
   end
   vector( all( ~vector, 2 ), : ) = []; %row clean
end