% K-NN using processed data input
% Copyright By Baohua Sun
% 20120409
close all
clear all
clc

%%
% GenerateProcessedDataMat

%% Training
load ProcessedTrainDataMatFile.mat
TrainingData=imData;
Group = imLabel;
% % KNN
% ClassTraining = knnclassify(TrainingData, TrainingData, Group);
% errorTrainingData = sum((ClassTraining-imLabel)~=0)
% errorRateTrainingData = errorTrainingData / size(TrainingData,1)
% 
% %% Testing
% clear imData imLabel
load ProcessedTestDataMatFile.mat
% TestingData=reshape(imData,size(imData,3),64);
TestingData=imData;
% KNN
K=6
Class = knnclassify(TestingData, TrainingData, Group,K);
errorTestingData = sum((Class-imLabel)~=0)
errorRateTestingData = errorTestingData / size(TestingData,1)
