num_Clusters = 30;
finished = 0;
differentIterations = 50;
iterationsDone = 0;
timesToDo = 100;
timesDone = 0;
counter = 0;
minValuesPerCluster = 10;
centersCounter = num_Clusters;
centsDist = 100;
equalThresh = 0.0001;

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');

 
% We are using display_network from the autoencoder code
display_network(images(:,1:100)); % Show the first 100 images
disp(labels(1:10));
while(iterationsDone < differentIterations)
    centers = getRandCenters(images, num_Clusters);

    oldCentHolder = zeros(size(centers, 1), size(centers, 2));
    centsDist = 100;
    timesDone = 0;
    centersCounter = num_Clusters;
    %Sets below to repeat until done or a certain amount of times
    while(~(centsDist < equalThresh) && (timesDone < timesToDo))
        %Get the center that the vector in image is closest to.
        closestVectors = findMinimumDistance(images, centers(:,1:centersCounter));

        %Get the new centers based on the clustering
        centersCounter = 0;
        oldCentHolder = centers;
        for j = 1:num_Clusters
            average = zeros(size(images, 1), 1);
            counter = 0;

            for k = 1:size(images, 2)
                if (closestVectors(k) == j)
                    average = average + images(:,k);
                    counter = counter + 1;
                end
            end
            if(counter > 0 && counter > minValuesPerCluster)
                centersCounter = centersCounter + 1;
                centers(:,centersCounter) = average/counter;
                %disp(counter + " at center: " + (centersCounter));
            end
        end
        timesDone = timesDone + 1;
        %name = "file" + timesDone + ".csv";
        centsDist = sqrt(sum(sum(((oldCentHolder - centers).^2))));
        fprintf("%d times with %d clusters\n", timesDone, centersCounter);
    end
    iterationsDone = iterationsDone + 1;
    fprintf("%d iterations done\n", iterationsDone);
    centName = "centerLocationsIteration" + iterationsDone + ".csv";
    csvwrite(centName, centers(:,1:centersCounter));   
end
