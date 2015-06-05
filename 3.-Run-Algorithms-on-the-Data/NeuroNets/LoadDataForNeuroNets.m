clear all
close all
clc

load ProcessedTrainDataMatFile
imDataTrain=imData';%Training data attributes, size: 64*3823
imLabelTrain=imLabel';%Training data labels, size: 1*3823

clear imData imLabel
load ProcessedTestDataMatFile
imDataTest=imData';%Testing data attributes, size: 64*1797
imLabelTest=imLabel';%Testing data labels, size: 64*1797

clear imData imLabel
