% Gaussian model
% Copyright Baohua Sun
% 20120409
close all
clear all
clc

%% 
% [imData imLabel]=fun_ReadOriginalData2('TrainData');
% [imData imLabel]=fun_ReadOriginalData2('validate');
load TrainDataMatFile.mat
% load ValidDataMatFile.mat

K=10;
MeanDigitFigure=zeros(32,32,K);
figure
for k=0:K-1
    MeanDigitFigure(:,:,k+1)=sum(imData(:,:,imLabel==k),3)/sum(imLabel==k);
    subplot(2,5,k+1)
    imagesc(MeanDigitFigure(:,:,k+1))
%     colormap('gray')
%     imshow(MeanDigitFigure(:,:,k+1)>0.5)
%     MeanDigitFigure(:,:,k+1)=MeanDigitFigure(:,:,k+1)>0.5;
end


N=size(imData,3);
Decision=zeros(N,1);
for n=1:N
    distortion=zeros(1,K);
    for k=0:K-1
        distortion(k+1)=sum(sum((double(imData(:,:,n))-MeanDigitFigure(:,:,k+1)).^2));
    end
    [tempDecision Decision(n)]=min(distortion);
    if Decision(n)-1~=imLabel(n) && n<80 
        figure
        subplot(1,2,1)
        imagesc(MeanDigitFigure(:,:,Decision(n)))
%         colormap('gray')
        subplot(1,2,2)
        imagesc(imData(:,:,n))
%         colormap('gray')
        xlabel(num2str(imLabel(n)))
    end
end
Nerrors=sum(Decision-1~=imLabel)
errorRateTrainData=Nerrors/N

%%
clear imData imLabel
% [imData imLabel]=fun_ReadOriginalData('TestData');
load TestDataMatFile.mat
N=size(imData,3);
Decision=zeros(N,1);
for n=1:N
    distortion=zeros(1,K);
    for k=0:K-1
        distortion(k+1)=sum(sum((double(imData(:,:,n))-MeanDigitFigure(:,:,k+1)).^2));
    end
    [tempDecision Decision(n)]=min(distortion);
    if Decision(n)-1~=imLabel(n) && n<80 
        figure
        subplot(1,2,1)
        imagesc(MeanDigitFigure(:,:,Decision(n)))
%         colormap('gray')
        subplot(1,2,2)
        imagesc(imData(:,:,n))
%         colormap('gray')
        xlabel(num2str(imLabel(n)))
    end
end
Nerrors=sum(Decision-1~=imLabel)
errorRateTestData=Nerrors/N
