function minimumDistVect = findMinimumDistance(images, centers)
minimumDistVect = zeros(1, size(images, 2));
distances = zeros(1, size(centers,2));
for i = 1:size(images, 2)
    %distances = zeros(1, size(centers, 2));
    for c = 1:size(centers, 2)
        distance = sqrt(sum(((images(:,i) - centers(:,c)).^2) ));
        distances(c) = distance;
    end
    [~, minimumDistVect(i)] = min(distances);
end   
end
%distances = sqrt(sum((images - centers) .^2));
%disp(distances);
%[~, minimumDistVect] = min(distances);


%Use center = [images(:,10), images(:,10)] to create centers