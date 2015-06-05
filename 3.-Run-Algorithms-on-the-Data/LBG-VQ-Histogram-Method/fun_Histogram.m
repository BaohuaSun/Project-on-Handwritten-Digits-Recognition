function Hist=fun_Histogram(ClassResult,Centroids,GroundTruth)
%histogram classification.
% ClassResult is the the cluster number from 2^nLBG clusters for
% each edge position in Training Data. Centroids are the x^nLBG centroids given in LBG-VQ.
% GroundTruth  is the ground truth of each edge position in Training Data,
% i.e. the class label of 'D','N','P'.'Q', for all Training Data.
% [DimeHist,NickelHist,PennyHist,QuarterHist] returned by the function are the histogram value of each class, and each element is a 2^nLBG vector.

z = Centroids;
nClust1 = size(z,1);
minProb=1e-5;%avoid log(zero probability)

K=max(GroundTruth)+1;
Hist=zeros(nClust1,K);
% Build histogram
for nn=1:K
    for i=1:nClust1
        Hist(i,nn)=sum(ClassResult(GroundTruth==nn-1)==i);
    end
    Hist(:,nn)=Hist(:,nn)/sum(Hist(:,nn));
    Hist(Hist(:,nn)==0)=minProb;
end
% Plot the histograms
figure('name', 'Histograms')
hHists = bar(Hist);
colorSet=['bgrcmyk']; 
colorSelection=rand(K,3);
legendStr=cell(1,K);
for kk=1:K
%     set(hHists(kk), 'FaceColor', colorSet(mod(kk,7)+1));
    set(hHists(kk), 'FaceColor', colorSelection(kk,:));
    legendStr{kk}=num2str(kk-1);
end
legend(legendStr)
legend('location', 'nw')
legend boxoff
xlabel('Centroid Number', 'fontsize', 28)
ylabel('Probability', 'fontsize', 28)
set(gca, 'fontsize', 24)
