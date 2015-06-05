
%Refrence
%Introduction to Pattern Recognition by Theodoridis,Pikrakis..
clc
close('all');
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Data generation part%%%%%%%%%%%%%%%%%%%%%%%%%%
load ProcessedTrainDataMatFile
% d=2;   % Dimensionality of the vectors.
% N=10; % Number of vectors
% 
% % Generate the training set X1
% rand('seed',0);
% X1=10*rand(d,N)-5;  % d by N matrix i.e. 2 by 150 matrix.

N=1500;
X1=(imData(1:N,:))';

%Pre-allocation.
% y1 = zeros(1,N);
% 
% for i=1:N
%     t=0.05*(X1(1,i)^3+X1(1,i)^2+X1(1,i)+1); %Just a random polynomial taken.
%     if(t>X1(2,i))  %Now for classification purpose just test to ensure it in either +1 or -1 class.
%         y1(i)=1;
%     else
%         y1(i)=-1;
%     end
% end
y1=sign((imLabel(1:N,:))'-4.9);

% Generate the test set X2
% rand('seed',100)
% X2=10*rand(d,N)-5;
% for i=1:N
%     t=0.05*(X2(1,i)^3+X2(1,i)^2+X2(1,i)+1);
%     if(t>X2(2,i))
%         y2(i)=1;
%     else
%         y2(i)=-1;
%     end
% end
load ProcessedTestDataMatFile
% y2 = zeros(1,N);
X2=(imData(1:N,:))';
y2=sign((imLabel(1:N,:))'-4.9);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot the training set X1
% figure(1), 
% plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==-1),X1(2,y1==-1),'bo')
% figure(1), axis equal



% Now for running kernel perceptron algorithm.
max_iter=3000;
[a,iter,count_misclas]=kernel_perceptrion1(X1,y1,max_iter);

%Preallocation
out_train = zeros(1,N);
out_test = zeros(1,N);

%Compute the training error.
%N is the number of training vectors or data length.
for i=1:N 
    K=X1'*X1(:,i); %Linear Kernal. k = u*v';
    out_train(i)=sum((a.*y1).*K')+sum(a.*y1);
end

err_train = sum(out_train.*y1<0)/length(y1)

%Compute the testing error.
for i=1:N
    K= X1'*X2(:,i); %Linear Kernal. k = u*v';
    out_test(i)=sum((a.*y1).*K')+sum(a.*y1);
end

err_test=sum(out_test.*y2<0)/length(y2)

%Count the total number of misclassification during training.
sum_pos_a=sum(a>0)

% 
% 
% err_train =
% 
%     0.1980
% 
% 
% err_test =
% 
%     0.2007
% 
% 
% sum_pos_a =
% 
%    754
