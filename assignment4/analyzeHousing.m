% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% analyzeHousing.m analyses the data from dataForTesting.mat. It first
% loads and cleans the data. Then does PCA on the data, performs linear
% regression, and calculates fit-quality for different models. 

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

%% Question 2(a)
% create a matrix of the inter-correlations of pred
figure('Name', 'Question 2(a)', 'Position', [830 150 600 500]);
corrPred = corr(pred);
imagesc(corrPred);
colorbar;

% Question)
%   Using imagesc and corr, create a matrix of the inter-correlations of 
%   pred. How many variables correlate well?
% Answer)
% The three variable pairs that correlate well are: INDUS(3)&NOX(5), 
% INDUS(3)&TAX(10) and RAD(9)&TAX(10). These three variable pairs all have 
% correlation coefficients of over 0.8.


%% Question 2(b)
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

% Question)
%   Can you identify �outliers� in this plot? Use the data cursor to write
%   down a few indices of potential outliers and add them to the script.
% Answer)
% The observation indices of the potential outliers are 54, 65 and 115.


%% Question 2(c)
%   Explained contains the explained variance of each of the principal 
%   components. How many components do you need to explain 70% of the 
%   variance? How many to explain 90%?
% Answer)
% To explain 70% of the variance we need 3 components. We can explain 
% 71.21187451% of variance with 3 components.
% To explain 90% of the variance we need 9 components. We can explain 
% 91.41254014% of variance with 9 components.

%% Question 2(d)
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


%% Question 2(e) 
% do the full fit using all 13 dimensions of the original data pred
P = [ones(206, 1) score(:, 1 : 13)];
a = P \ price;
% determine the fit-quality of the full model
orig_fitqual = norm(P * a - price)

% Question)
%   What is the fit-quality of this full model? Better or worse - and why?
% Answer)
% The fit-quality of the full model is 63.3857. The fit-quality of the
% three most "variance-containing" directions in the data is 82.3468. The
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

% Question)
%   Which dimensions consistently have the lowest residual? Can you 
%   interpret them using the names and descriptions in the file?
% Answer)
% Dimensions 1, 4 and 13 consistently have the lowest residual.
% Dimension 1 (CRIM) is per capital crime rate by town, dimension 4 (CHAS)
% is the Charles River dummy variable and dimension 13 (LSAT) is the
% percentage of lower status of the population. 
% As dimension 1 has a negative correlation to the housing prices, 
% we can interpret that the lower per capital crime rate by town, the
% higher housing prices. 
% Dimension 4 has a positive correlation to the housing prices, so we can
% interpret that the closer to the Charles River, higher the housing price.
% Dimension 13 has a negative correlation to the housing prices, so we can
% interpret that the lower percentage of lower status of the housing
% population, higher the housing price. 

% Question)
%   So is this fit-quality good? Can PCA help us to select "good" 
%   dimensions for fitting our linear model?
% Answer)
% Compared to the fit-quality of the full model or the model with the best
% 3 dimensions from all possible sets of 13 dimensions, the PCA model is
% not as good. PCA does not consider the correlations between the features
% and the dependent variable, it just picks out the principle components 
% with largest variance. This might erase out features with small variance, 
% but has a strong correlation with the dependent variable. Therefore, 
% PCA is not the best way to select good dimensions for fitting our linear 
% model. 