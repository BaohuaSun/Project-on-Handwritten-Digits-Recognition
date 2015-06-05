function TestingDataClassResult=fun_ClassifyTesingData(Centroids,TestingDataDEdges)
% classifying the testing data according to the centroids obtained in
% LBG-VQ. return the  ClassResult for TestingData

% Centroids are 2^nLBG centroids given in LBG-VQ, TestingDataEdges are the edge positions
% for all the testing data. 
% TestingDataClassResult is the classification result given by a number
% from 1 to 2^nLBG for each row in input TestingDataDEdges

z=Centroids;
nClust=length(z);
d=TestingDataDEdges;
N=length(d);
dst = zeros(N,nClust);
for ii = 1:nClust
    dst(:,ii) = dist(z(ii,:), d(:,1:2)')';
end
[dists,classes] = min(dst, [], 2);
TestingDataClassResult=classes';
