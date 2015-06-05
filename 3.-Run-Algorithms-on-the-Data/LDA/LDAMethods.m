% LDA
% Copyright By Baohua Sun
% 20120409
close all
clear all
clc

%% Training
% [imData imLabel]=fun_ReadOriginalData('TrainData');
load TrainDataMatFile.mat
TrainingData=reshape(imData,size(imData,3),1024);
Group = imLabel;
% KNN
ClassTraining = classify(TrainingData, TrainingData, Group);
errorTrainingData = sum((ClassTraining-imLabel)~=0)
errorRateTrainingData = errorTrainingData / size(TrainingData,1)

%% Testing
% [imData imLabel]=fun_ReadOriginalData('TestData');
clear imData imLabel
load TestDataMatFile.mat
TestingData=reshape(imData,size(imData,3),1024);
% KNN
Class = classify(TestingData, TrainingData, Group);
errorTestingData = sum((Class-imLabel)~=0)
errorRateTestingData = errorTestingData / size(TestingData,1)
