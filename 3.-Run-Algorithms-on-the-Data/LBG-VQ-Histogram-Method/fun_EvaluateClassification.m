function errorRate=fun_EvaluateClassification(Hist,Centroids,GroundTruth,ClassResult,allcoins)
% evaluate training set
tempInputName=inputname(3);
tempInputName=tempInputName(1:5);
if tempInputName=='Train'
    load TrainDataMatFile
else
    load TestDataMatFile
end

K=size(Hist,2);
errors=zeros(K,1);
indBegin=1;
indEnd=1;
NumMemberInEachCluster=zeros(K,1);
for jj=1:size(allcoins,3)
    indEnd=indBegin+sum(sum(allcoins(:,:,jj)))-1;
    tempCurrent=ClassResult(indBegin:indEnd);
    indBegin=indEnd+1;
    LogLikelihood=zeros(K,1);
    for i=1:length(Centroids)
        for kk=1:K
            LogLikelihood(kk)=LogLikelihood(kk) + sum(tempCurrent==i) * log(Hist(i,kk));
        end
        %         LogLikelihood(1)=LogLikelihood(1) + sum(tempCurrent==i) * log(DimeHist(i));
        %         LogLikelihood(2)=LogLikelihood(2) + sum(tempCurrent==i) * log(NickelHist(i));
        %         LogLikelihood(3)=LogLikelihood(3) + sum(tempCurrent==i) * log(PennyHist(i));
        %         LogLikelihood(4)=LogLikelihood(4) + sum(tempCurrent==i) * log(QuarterHist(i));
    end
    [dummy indMax]=max(LogLikelihood);
    tempIndGroundTruth=GroundTruth(indEnd)+1;
    NumMemberInEachCluster(tempIndGroundTruth)=NumMemberInEachCluster(tempIndGroundTruth)+1;
    if indMax ~= tempIndGroundTruth
        errors(tempIndGroundTruth)=errors(tempIndGroundTruth)+1;
%         display(strcat('wrong decision for',char(127),num2str(tempIndGroundTruth-1),char(127), 'image as',char(127),num2str(indMax-1)))
%         imshow(imData(:,:,jj))
%         pause
    end
end
[errors NumMemberInEachCluster]
errorRate=errors./NumMemberInEachCluster;
