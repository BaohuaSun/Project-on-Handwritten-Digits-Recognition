% Homework3 Problem 4
% Please put the file "Coins" under the same directory with this "Problem4.m" file

% Copyright by Baohua Sun
% 2012 Feb. 21

close all
clear all
clc
%% read training images and get the data of edge position, matrix for all edges in training data, and the ground truth for the edge positons.
[TrainingDataDEdges TrainingDataAllcoins TrainingDataGroundTruth]=fun_ReadOriginalData('TrainData');
save TrainingDataCoinEdgesData TrainingDataDEdges TrainingDataAllcoins TrainingDataGroundTruth%save the result in TrainingDataCoinEdgesData.mat

%% LBG VQ
load TrainingDataCoinEdgesData%load the result
nLBG=5;%set the number of LBG iterations to run, creates 2^nLBG clusters
fudge=0.1;% set the amount to add to split
display('Press any key other than q to see the VQ algorithm run.');%some instructions to display on how to use LBG-VQ
display('Press q to split the centroids (the LBG part of things)');
display('and keep pressing any key (space bar is good) to watch convergence.');
display('After you observe the convergence of the 2^nLBG clusters,');
display('press q to end LBG-VQ.');
[TraingDataClassResult Centroids]=fun_LBG_VQ(TrainingDataDEdges,nLBG,fudge);%do LBG-VQ, clustering the TrainingDataDEdges into 2^nLBG clusters, fudge is the amount to add to split. return the Centroids and TraingDataClassResult(which is the cluster number from 2^nLBG clusters for each edge position in TrainingDataDEdges)
Centroids%show the Centroid obtained by LBG-VQ
save CoinDataClusterResult TraingDataClassResult Centroids%save the results

%% Histogram classification
load CoinDataClusterResult%load the results
Hist=fun_Histogram(TraingDataClassResult,Centroids,TrainingDataGroundTruth);%do histogram. using the TraingDataClassResult,Centroids,TrainingDataGroundTruth, and return the histogram value of [DimeHist,NickelHist,PennyHist,QuarterHist], each element is a 2^nLBG vector.

%% Evaluate Training Data
load TrainingDataCoinEdgesData%load the result of LBG-VQ
TrainingDataErrorRate=fun_EvaluateClassification(Hist,Centroids,TrainingDataGroundTruth,TraingDataClassResult,TrainingDataAllcoins);
TrainingDataErrorRate%show the ErrorRate of TrainingData

%% read testing images and get the data of edge position, matrix for all edges in testing data, and the ground truth for the edge positons.
[TestingDataDEdges TestingDataAllcoins TestingDataGroundTruth]=fun_ReadOriginalData('TestData');%read the test data
save TestingDataCoinEdgesData TestingDataDEdges TestingDataAllcoins TestingDataGroundTruth%save the result in TestingDataCoinEdgesData.mat

%% classifying the testing data according to the centroids obtained in LBG-VQ
load TestingDataCoinEdgesData%load the data
TestingDataClassResult=fun_ClassifyTesingData(Centroids,TestingDataDEdges);%classifying the testing data according to the centroids obtained in LBG-VQ. return the  ClassResult for TestingData

%% Evaluate Testing Data
TestingDataErrorRate=fun_EvaluateClassification(Hist,Centroids,TestingDataGroundTruth,TestingDataClassResult,TestingDataAllcoins);%evaluate the classification result for the testing data. return the ErrorRate of TestingData
TestingDataErrorRate%show the ErrorRate of TestingData
