function [imData imLabel]=fun_ReadOriginalData2(FileName)
%% copyright by Baohua Sun
% Mar. 23, 2012

% read training images and get the data of edge position, matrix for all
% edges in training data, and the ground truth for the edge positons.

%read the file path,and return dEdges(which is
%the 2-D positions of the edges of training data),
%allcoins(which is a 32*32*N matrix containing all the 32*32 images from the data),
% DataGroundTruth(which is the ground truth of each edge position in dEdges, i.e. the class label of 0,1, ... , 9 for all Data samples.
%%
ftemp = load(strcat(FileName,'.txt'));
Ntrain=size(ftemp,1)/33;
fid = fopen(strcat(FileName,'.txt'));
imData=zeros(32,32,Ntrain);
imLabel=zeros(Ntrain,1);
% PosHandWritten=[];
% DataGroundTruth=[];
for n=1:Ntrain
    imTemp=[];
    for i=1:32
        tline = fgetl(fid);
        if ~ischar(tline), break,   end
        imTemp=[imTemp;tline];
    end
    [Nrow Ncol]=size(imTemp);
    im2=zeros(Nrow,Ncol);
    for nrow=1:Nrow
        for ncol=1:Ncol
            im2(nrow,ncol)=str2num(imTemp(nrow,ncol));
        end
    end
    imData(:,:,n)=im2;
    tline = fgetl(fid);
%     [eX,eY] = find(im2 == 1);%get handwritten position
%     PosHandWritten=[PosHandWritten;eX,eY];%save the edge position
    if ~ischar(tline),   break,   end
    imLabel(n)=str2num(tline);
%     DataGroundTruth=[DataGroundTruth imLabel(n)*ones(1,length(eX))];%save the class id of each sample using 0,1,2,...,9 to represent different classes.

%     imshow(imData(:,:,n))
%     (DataGroundTruth)
%     (PosHandWritten)
%     pause
    
end
fclose(fid);
if FileName(1:5)=='Train'
    save('TrainDataMatFile', 'imData', 'imLabel')
elseif FileName(1:4)=='Test'
    save('TestDataMatFile', 'imData', 'imLabel')
else
    save('ValidDataMatFile', 'imData', 'imLabel')
end
