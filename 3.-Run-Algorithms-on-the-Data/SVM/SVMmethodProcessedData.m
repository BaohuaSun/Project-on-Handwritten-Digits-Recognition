% SVM using processed data input
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
Group = (imLabel>=5);
% SVM
svmStruct = svmtrain(TrainingData,Group,'showplot',true);
Class = svmclassify(svmStruct,TrainingData,'showplot',true);
errorTrainingData = sum((Class-Group)~=0)
errorRateTestingData = errorTrainingData / size(TrainingData,1)

%% Testing
clear imData imLabel Class
load ProcessedTestDataMatFile.mat
% TestingData=reshape(imData,size(imData,3),64);
TestingData=imData;
imLabel = (imLabel>=5);
% KNN
figure
Class = svmclassify(svmStruct,TestingData,'showplot',true);
errorTestingData = sum((Class-imLabel)~=0)
errorRateTestingData = errorTestingData / size(TestingData,1)


