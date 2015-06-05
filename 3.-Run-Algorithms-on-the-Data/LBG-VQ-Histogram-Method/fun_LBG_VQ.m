function [ClassResult Centroids]=fun_LBG_VQ(d,nLBG,fudge)
%% this is a modified version of LBG-VQ from the code given by Prof. McNeill given in class.
% Seth McNeill
% 2012 February 14
% modified by Baohua Sun for Homework 3 on 2012 March 1

% d is the 2-D data to be clustered. nLBG is the number of iterations of
% LBG, creat 2^nLBG clusters. fudge is the amount to add to split
% this function returns the LBG result of the 2^nLBG Centroids and
% ClassResult, which is the classification result given by a number
% from 1 to 2^nLBG for each row in input d

% press any key other than q to see the VQ algorithm run. Press q to split
% the centroids (the LBG part of things) and keep pressing any key (space
% bar is good) to watch convergence.


%% LBG VQ Algorithm Demo
% Constants
nClust = 1; % number of clusters in current iteration of LBG
N=length(d);
% Plot the data
hBase = figure('name', 'Data');
orient landscape
plot(d(:,1), d(:,2), '.', 'markersize', 12)
hold all
set(gca, 'fontsize', 16)
xlabel('X_1', 'fontsize', 20)
ylabel('X_2', 'fontsize', 20)
axis equal

% initialize z to mean of all data
z = mean(d(:,1:2));
figure(hBase)
plot(z(:,1), z(:,2), 'or', 'linewidth', 2, 'Markersize', 10)
while(waitforbuttonpress ~= 1)
end
key = get(gcf, 'CurrentCharacter');

hLast = figure('name', 'Data');
distortion = zeros(100,1);
distortion(1) = 0; % need to fill this in correctly
distEnd = 2; % index to end of distortion data
for kk = 1:nLBG % LBG outer loop
    ztemp = z;
    nClust = 2^kk;
    z = zeros(nClust, 2); % initialize z
    epsl = [(round(rand())*2-1)*fudge ...
        (round(rand())*2-1)*fudge];
%     keyboard
    z(1:(2^(kk-1)),:) = ztemp - repmat(epsl, size(ztemp, 1), 1);
    z((2^(kk-1)+1):end,:) = ztemp + repmat(epsl, size(ztemp, 1), 1);

    % display split clusters
    clf
    orient landscape
    subplot(2,1,1)

    plot(d(:,1), d(:,2), '.', 'markersize', 12)

    hold all
    plot(z(:,1), z(:,2), 'or', 'linewidth', 2, 'Markersize', 10)
    if(size(z,1) > 2)
        hv = voronoi(z(:,1), z(:,2), 'r');
        set(hv, 'linewidth', 2)
    end
    set(gca, 'fontsize', 16)
    xlabel('X_1', 'fontsize', 20)
    ylabel('X_2', 'fontsize', 20)
    subplot(2,1,2)
    plot(1:distEnd, distortion(1:distEnd), 'x-', 'linewidth', 2, 'markersize', 10)
    xlabel(['Iteration, (distortion: ' num2str(distortion(distEnd), '%.2f') ...
        ')'], 'fontsize', 20)
    ylabel('Distortion', 'fontsize', 20)
    set(gca, 'fontsize', 16)

    while(waitforbuttonpress ~= 1)
    end
    key = get(gcf, 'CurrentCharacter');
    
    jj = 1;
    dst = zeros(N,nClust);
    % do the classification and update loop until key isn't 'q'
    while(key ~= 'q')
        % Classification:
        for ii = 1:nClust
            dst(:,ii) = dist(z(ii,:), d(:,1:2)')';
        end
        [dists,classes] = min(dst, [], 2);
        ClassResult=classes';
        distortion(distEnd) = sum(dists); % store the distortion to plot
        % Update:
        for ii = 1:nClust
            z(ii,:) = mean(d(classes == ii,1:2));
        end
        Centroids=z;
        % Display:
        clf
        orient landscape
        subplot(2,1,1)
        plot(d(:,1), d(:,2), '.', 'markersize', 12)
        hold all
        plot(z(:,1), z(:,2), 'or', 'linewidth', 2, 'Markersize', 10)
        if(size(z,1) > 2)
            hv = voronoi(z(:,1), z(:,2), 'r');
            set(hv, 'linewidth', 2)
        end
        set(gca, 'fontsize', 16)
        xlabel('X_1', 'fontsize', 20)
        ylabel('X_2', 'fontsize', 20)
        subplot(2,1,2)
        plot(2:distEnd, distortion(2:distEnd), 'x-', 'linewidth', 2, 'markersize', 10)
        xlabel(['Iteration, (distortion: ' num2str(distortion(distEnd), '%.2f') ...
            ')'], 'fontsize', 20)
        ylabel('Distortion', 'fontsize', 20)
        set(gca, 'fontsize', 16)

        while(waitforbuttonpress ~= 1)
        end
        key = get(gcf, 'CurrentCharacter');
        distEnd = distEnd + 1;
        jj = jj + 1;
    end

end

