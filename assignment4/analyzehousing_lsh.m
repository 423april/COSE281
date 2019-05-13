% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% analyzeHousing.m


%%%%%%%%%%%%%%%%NOTES%%%%%%%%%%%%
% ask prof if he really meant data and not pred
% 
% check if price should be included in computing the correlation coeffs
% (esp in part a)
% 
% 

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all
clear all
clc

% load dataForTesting.mat
load dataForTesting

% set all data elements that are negative and that are above 1000000 to
% NaN
data_org = data;
data(data < 0 | data > 1000000) = NaN;

% replace all NaN values in each column of the data by the
% column’s median value.
[nanRow, nanCol] = find(isnan(data));
columnMedians = nanmedian(data);
for i = 1 : length(nanRow)
    data(nanRow(i), nanCol(i)) = columnMedians(nanCol(i));
end

% import the category names and descriptions from the file
% housingDescription.txt into two separate variables using a function or
% script
makeDescTable;
housingDescription = table2array(housingDescription);


% split the data into 13 predictor variables, pred, and 1 target variable,
% price.
pred = data(:, 1 : 13);
price = data(:, 14);

%% Question a)
%    Using imagesc and corr, create a matrix of the inter-correlations of
%    pred. How many variables correlate well?
figure('Name', 'Question 2(a)');
corrPred = corr(data);

%%%%%%%%%%%%%%%%%%(corr(data) confirms that var 13 is the "best" predictor of price (moderately strong -ve correlation)%%%%%%%%%%%%%%%%%%%%%%%%%%


imagesc(corrPred);
colorbar;

% variables INDUS(3)&NOX(5), INDUS(3)&TAX(10) and RAD(9)&TAX(10) have
% correlation coefficients of over 0.8.

%%%%%%%%%%%%%%%(ATQ: "how many")%%%%%%%%%%%%

%% Question b)
% create a vector of weights
w = 1 ./ var(pred);
% do weighted PCA
[wcoeff, score, latent, ~, explained] = pca(pred, 'VariableWeights', w); 
% get orthogonal eigenvectors
coefforth = inv(diag(std(pred))) * wcoeff;

% plot biplot to take a look at how each point is projected, and how the 
% original 13 predictor axes have been rotated in a new, reduced coordinate
% system
vlabels = (housingDescription(1 : 13, 1))';
figure('Name', 'Question 2(b)', 'Position', [0 0 1000 1000]);
biplot(coefforth(:, 1 : 3), 'Scores', score(:, 1 : 3), 'Varlabels', vlabels');


%%%%%%wcoeff(:, 1 : 3)
%%%%%%%%(used 3 vars)%%%%%%%%%%%%

% outliers
% (6.158, 53.0692), (-59.8868, -5.3262), (31.0445, -26.2571)


%%%%%%%%%%%(change to indices)%%%%%%%%%%%%
%%%%%%%%54, 65, 115%%%%%%%%%%%

%% Question c)
% variable 'explained' contains the percentage of the total variance
% explained by each principal component. 
% to explain 70% of the variance we need 3 components. we can explain 
% 71.21187451% of variance with 3 components.
% to explain 90% of the variance we need 9 components. we can explain 
% 91.41254014% of variance with 9 components.

%% Question d)


% fit-quality %%%%%%%%%of the 3 most "variance-containing" directions
P = [ones(206, 1) score(:, 1 : 3)];
a = P \ price;
fitqual = norm(P * a - price)


%% e)

% fit-quality of full model
P = [ones(206, 1) score(:, 1 : 13)];
a = P \ price;
fitqual = norm(P * a - price)

%%%%%%fit quality is better, since all variables have been considered%%%



%less efficent but easier summing
r2orig = zeros(13, 13, 13);

for i = 1 : 13
    for j = 1 : 13
        for k = 1 : 13
            if (i == j  || i == k || j == k)
                continue;
            end
            P = [ones(206, 1) pred(:, i) pred(:, j) pred(:, k)];
            a = P \ price;
            r2orig(i, j, k) = norm(P * a - price); %note that all norms are higher than the norm of the full model
        end
    end
end

% sum up all the values
check = sum(sum(r2orig));

% check the value of the closest variable
bestval = min(check)

% find the index of the closest variable
minpos = find(check == min(check))

% note again that all norms are higher than the norm of the full model
min(r2orig(r2orig ~= 0))
% 1, 4 and 13 produce the lowest dist with just 3 vars


%%%moreover, those directions produce an L2(?) norm less than that of PCA,
%%%so it seems that PCA does not help in selecting the 3 "best" dimensions
%%%for "fitting the linear model"(?)

%%%%however, fit quality seems decent (82 (2 s.f.) vs 73 (2 s.f.))

%%%%lowest residual dimensions: 1, 4 and 13???
%%%%13: the more people with lower status there are, the cheaper the price.
%%%%etc.

% for i = 1 : 13
%     for j = (i + 1) : 13
%         for k = (j + 1) : 13
%             P = [ones(206, 1) pred(:, i) pred(:, j) pred(:, k)];
%             a = P \ price;
%             r2orig(i, j, k) = norm(P * a - price);
%         end
%     end
% end