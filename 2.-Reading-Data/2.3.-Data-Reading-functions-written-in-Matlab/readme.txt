1. Read Original data

There are two functions to read original data:
 
[PosHandWritten imData DataGroundTruth]=fun_ReadOriginalData(FileName)%this is used in LBG-VG+Histogram.
[imData imLabel]=fun_ReadOriginalData2(FileName)% this is used in all the other 7 methods.
 
The data being read will be saved in "TrainDataMatFile.mat" and "TestDataMatFile.mat"  respectively.
2. Read Preprocessed data

There is one function to read preprocessed data into "ProcessedTestDataMatFile":
 
GenerateProcessedDataMat.m% this is used in all the methods that use preprocessed data
 
The data being read will be saved in "ProcessedTrainDataMatFile.mat" and "ProcessedTestDataMatFile.mat"  respectively.
 
 
 
 
All the data-reading functions are under the folder of  Functions for Reading Data.
 
 
 
OK, the data are already read into the .mat file, we can proceed to use the data in different algorithms!
