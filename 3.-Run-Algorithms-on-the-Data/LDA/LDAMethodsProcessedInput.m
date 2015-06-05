% LDA using processed data input
% Copyright By Baohua Sun
% 20120409
close all
clear all
clc

%%
% GenerateProcessedDataMat

%% Training
load ProcessedTrainDataMatFile.mat
% TrainingData=reshape(imData,size(imData,3),64);
TrainingData=imData;
Group = imLabel;
% KNN
ClassTraining = classify(TrainingData, TrainingData, Group,'diaglinear');
errorTrainingData = sum((ClassTraining-imLabel)~=0)
errorRateTrainingData = errorTrainingData / size(TrainingData,1)

%% Testing
clear imData imLabel
load ProcessedTestDataMatFile.mat
% TestingData=reshape(imData,size(imData,3),64);
TestingData=imData;
% KNN
Class = classify(TestingData, TrainingData, Group,'diaglinear');
errorTestingData = sum((Class-imLabel)~=0)
errorRateTestingData = errorTestingData / size(TestingData,1)
