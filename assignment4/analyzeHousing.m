% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% analyzeHousing.m analyzes the data from dataForTesting.mat. It first
% loads and cleans the data. Then does PCA on the data and performs linear
% regression. 

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all;
clear all;
clc;

% load dataForTesting.mat
load dataForTesting

% set all data elements that are negative and that are above 1000000 to 
% NaN
data_org = data;
data(data < 0 | data > 1000000) = NaN;

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
pred = data(:, 1 : 13);
price = data(:, 14);

%% Question 2a)
%   Using imagesc and corr, create a matrix of the inter-correlations of pred. How many
%   variables correlate well?
figure('Name', 'Question A');
corrPred = corr(pred);
imagesc(corrPred);
colorbar;

% the three variable pairs that correlate well are: INDUS(3)&NOX(5), 
% INDUS(3)&TAX(10) and RAD(9)&TAX(10). these three variable pairs all have 
% correlation coefficients of over 0.8.


%% Question 2b)
% create a vector of weights
w = 1 ./ var(pred);
% do weighted PCA
[wcoeff, score, latent, ~, explained] = pca(pred, 'VariableWeights', w); 
% get orthogonal eigenvectors
coefforth = inv(diag(std(pred))) * wcoeff; 

% plot bi-plot to take a look at how each point is projected, and how the 
% original 13 predictor axes have been rotated in a new, reduced coordinate
% system
vlabels = (housingDescription(1 : 13, 1))';
figure('Name', 'Question 2(b)', 'Position', [0 0 800 800]);
% plots biplot with the first three principal components
biplot(coefforth(:, 1 : 3), 'Scores', score(:, 1 : 3), 'Varlabels', vlabels');

% the observation indices of the potential outliers are 54, 65 and 115.


%% Question 2c)
% variable 'explained' contains the percentage of the total variance
% explained by each principal component. 
% to explain 70% of the variance we need 3 components. we can explain 
% 71.21187451% of variance with 3 components.
% to explain 90% of the variance we need 9 components. we can explain 
% 91.41254014% of variance with 9 components.

%% Question 2d)
% the number of components for reduction to be such that 70% is explained
% is 3. 

% create a fitting matrix P
P = [ones(206, 1) score(:, 1 : 3)];
% solve for the coefficients a using the backslash
a = P \ price;
% determine the residual as the norm(P * a - price) and print it out
% this is the fit-quality of the three most "variance-containing"
% directions in our data.
pca_fitqual = norm(P * a - price)


%% Question 2e)
%   So is this fit-quality good? Can PCA help us to select "good" dimensions
%   for fitting our linear model?

% do the full fit using all 13 dimensions of the original data pred
P = [ones(206, 1) score(:, 1 : 13)];
a = P \ price;
% determine the fit-quality of the full model
orig_fitqual = norm(P * a - price)

%   What is the fit-quality of this full model? Better or worse - and why?
% the fit-quality of the full model is 63.3857. the fit-quality of the
% three most "variance-containing" directions in the data is 82.3468. the
% fit-quality of the full model is better because considers all 13
% dimensions of the data. 

% take all possible sets of 3 dimensions from the original 13 dimensions
% and perform a linear regression
% save the fit-quality to vector variable r2orig
r2orig = zeros(13, 13, 13);
for i = 1 : 13
    for j = 1 : 13
        for k = 1 : 13
            if (i == j  || i == k || j == k)
                continue;
            end
            P = [ones(206, 1) pred(:, i) pred(:, j) pred(:, k)];
            a = P \ price;
            r2orig(i, j, k) = norm(P * a - price); % note that all norms are higher than the norm of the full model
        end
    end
end

% sum up all the values
check = sum(sum(r2orig));

% check the value of the closest variable
bestval = min(check);

% find the index of the closest variable
minpos = find(check == min(check));

% note again that all norms are higher than the norm of the full model
min(r2orig(r2orig ~= 0));

% dimensions 1, 4 and 13 consistently have the lowest residual.
% dimension 1 (CRIM) is per capital crime rate by town, dimension 4 (CHAS)
% is the Charles River dummy variable and dimension 13 (LSAT) is the
% percentage of lower status of the population. 
% as dimension 1 has a negative correlation to the housing prices, 
% we can interpret that the lower per capital crime rate by town, the
% higher housing prices. 
% dimension 4 has a positive correlation to the housing prices, so we can
% interpret that the closer to the Charles River, higher the housing price.
% dimension 13 has a negative correlation to the housing prices, so we can
% interpret that the lower percentage of lower status of the housing
% population, higher the housing price. 
