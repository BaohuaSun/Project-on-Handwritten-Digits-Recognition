function [a,iter,count_misclas]=kernel_perceptrion1(X,y,max_iter)

% X is lxN input matrix
% y is N dimensional of class label of the input data.
% a is N dimensional, contains # of misclassified data vector.
% iter # of iteration.
% count_misclas # of misclassifed vectors.

% [~,N]=size(X);
[d,N]=size(X);

% Computation of the Kernel values K(xi,xj)
K=zeros(N,N);
for i=1:N
    K(:,i)= X'*X(:,i); %Linear Kernel calculation k = u*v';
end


%Parameter initialization
a=zeros(1,N); %Total  no of misclas./vector
count_misclas=N; %No of misclass./iteration
iter=0;  %Number of iterations

%Main phase algorithm kernel perceptron.
while (count_misclas>0)&&(iter<max_iter)
    iter=iter+1;
    count_misclas=0;
    for i=1:N
        t=sum((a.*y).*K(i,:))+sum(a.*y);
        if(y(i)*t<=0)
            a(i)=a(i)+1;
            count_misclas=count_misclas+1;
        end
    end
end
