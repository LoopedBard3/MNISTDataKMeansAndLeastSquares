function chosenCenters = getRandCenters(vectors, numClusters)
chosenCenters = rand(size(vectors, 1), numClusters);
