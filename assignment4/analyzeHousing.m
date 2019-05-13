% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all;
clear all;
clc;

% load dataForTesting.mat
load dataForTesting

% set all data elements that are negative and that are above
% 1000000 to NaN
[negRow, negCol] = find(data < 0);
[abvRow, abvCol] = find(data > 1000000);
for i = 1: length(negRow)
    data(negRow(i), negCol(i)) = NaN;
end
for i = 1: length(abvRow)
    data(abvRow(i), abvCol(i)) = NaN;
end

% replace all NaN values in each column of the data by the column's
% median value
[nanRow, nanCol] = find(isnan(data));
for i = 1: length(nanRow)
    data(nanRow(i), nanCol(i)) = nanmedian(data(:, nanCol(i)));
end

% import the category names and descriptions from the text file
% housingDescription.txt into two separate variables
% use auto-generated script from Import Wizard: makeDescTable.m
makeDescTable;
housingDescription = table2array(housingDescription);

% split the data into 13 predictor variables pred [the first 13 columns of 
% data] and 1 target variable price [the 14th column of the data]
pred = data(:, 1:13);
price = data(:, 14);

%% Question a)
% Using imagesc and corr, create a matrix of the inter-correlations of pred. How many
% variables correlate well?
figure('Name', 'Question A');
corrPred = corr(pred);
imagesc(corrPred);
colorbar;

% variables INDUS(3)&NOX(5), INDUS(3)&TAX(10) and RAD(9)&TAX(10) have
% correlation coefficients of over 0.8.


%% Question b)
% create a vector of weights
w = 1 ./ var(pred);
% do weighted PCA
[wcoeff, score, latent, ~, explained] = pca(pred, 'VariableWeights', w); 
% get orthogonal eigenvectors
coefforth = inv(diag(std(pred))) * wcoeff; 

% plot bi-plot to take a look at how each point is projected, and how the 
% original 13 predictor axes have been rotated in a new, reduced coordinate
% system
vlabels = (housingDescription(1:13, 1))';
figure('Name', 'Question 2(b)', 'Position', [0 0 1000 1000]);
biplot(wcoeff(:,1:3), 'Scores', score(:,1:3), 'Varlabels', vlabels');

%%%%%%%%(used 3 vars)%%%%%%%%%%%%

% outliers
% (6.158, 53.0692), (-59.8868, -5.3262), (31.0445, -26.2571)


%%%%%%%%%%%(change to indices)%%%%%%%%%%%%

%% Question c)
% variable 'explained' contains the percentage of the total variance
% explained by each principal component. 
% to explain 70% of the variance we need 3 components. we can explain 
% 71.21187451% of variance with 3 components.
% to explain 90% of the variance we need 9 components. we can explain 
% 91.41254014% of variance with 9 components.

%% Question d)
