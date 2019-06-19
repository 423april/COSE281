% COSE281 ENGINEERING MATHEMATICS 2019 FINAL PROJECT
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% mlr.m - perform multiple linear regression and compare and the
%         performances of the different methods used

% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% load abalone data
load abalone.mat

%% Data Manipulation
% separate the dependent and independent variables

% create data table (the first column, sex, is discarded as it is
% a discrete variable)
data_table = abalone(:, 2 : 9);
data_table.Rings = data_table.Rings + 1.5; % adjust to represent age
data_table.Properties.VariableNames{end} = 'Age';

% construct a full data matrix as it can be easier to work with
data = table2array(abalone(:, 2 : 8));

% obtain labels (age = rings + 1.5)
age = table2array(abalone(:, 9)) + 1.5;


%% Multiple Linear Regression (All Data)

% obtain the matrix of correlations
figure('Position', [100 200 400 400])
correlations = corr([data age]);
imagesc(correlations)

% check variable with the strongest correlation with age
max_corr = max(correlations(1 : 7, end))
% Correlation with ShellWeight, the weight of the dried shell: 0.628
% Hence the weight of the dried shell alone will be the most telling
% feature if other variables were unavailable. This might be useful should
% one wish to gauge the age of an abalone whose shell was left behind, say,
% on the beach, especially given the fact that shells last considerably
% longer than the flesh of abalone, when one does not have easy access to a
% microscope to count the number of rings and/or when one cannot or does
% not wish to cut the shell itself (which conveniently also removes the
% necessity for staining the shell afterwards).

% use built-in functions to fit data to a linear model with all data
model = fitlm(data_table);
figure('Position', [600 100 600 500])
plot(model)

% Linear regression model:
%     Age ~ 1 + Length + Diameter + Height + WholeWeight + ShuckedWeight + VisceraWeight + ShellWeight
% 
% Estimated Coefficients:
%                      Estimate      SE        tStat        pValue   
%                      ________    _______    ________    ___________
% 
%     (Intercept)       4.4852     0.26913      16.666     2.0207e-60
%     Length           -1.5719      1.8248    -0.86143        0.38905
%     Diameter          13.361      2.2371      5.9725     2.5314e-09
%     Height            11.826      1.5481      7.6389     2.6997e-14
%     WholeWeight       9.2474     0.73264      12.622     7.1822e-36
%     ShuckedWeight    -20.214     0.82331     -24.552    1.9216e-124
%     VisceraWeight    -9.8297       1.304     -7.5381     5.8177e-14
%     ShellWeight       8.5762      1.1367      7.5446     5.5363e-14
% 
% 
% Number of observations: 4177, Error degrees of freedom: 4169
% Root Mean Squared Error: 2.22
% R-squared: 0.528,  Adjusted R-Squared 0.527
% F-statistic vs. constant model: 665, p-value = 0

% Comments: The adjusted R-squared value is not very high. The RMSE,
%           however, is comparable in performance to built-in ANN
%           functions that used only 70% of the data


%% Multiple Linear Regression

% use approximately 70% of the data for a regression model; the rest are
% used for validation
sz = floor(0.7 * size(data, 1));

% generate random indices to use for training
rng('shuffle')
random_indices = randperm(size(data_table, 1));
dataset = data_table(random_indices, :);

% segment the data into two sets using random indices
regData = data(random_indices(1 : sz), :);
valData = data(random_indices(sz + 1 : end), :);

% create corresponding training and validation ages
regAge = age(random_indices(1 : sz));
valAge = age(random_indices(sz + 1 : end));

% fit model with only a part of the data
model2 = fitlm(regData, regAge);

% extract coefficients
coefficients = table2array(model2.Coefficients(:, 1));

% calculate predictions by the model
predictions = [ones(size(valData, 1), 1) valData] * coefficients;

% calculate the RMSE value of the model
rmse = sqrt(sum((predictions - valAge) .^ 2) / size(valAge, 1))
% The RMSE is 2.26 on average, which is similar in value to the
% artificial neural "network" with a single neuron in the hidden layer. The
% difference in RMSE compared to the model above is minimal.


%% "Manual" Multiple Linear Regression
% solve for coefficients "manually" using the data above for verification
coeffs = [ones(size(regData, 1), 1) regData] \ regAge;

% predict age of abalone using manually computed coefficients
preds = [ones(size(valData, 1), 1) valData] * coeffs;

% compute differences
diff_coeff = sum(coefficients - coeffs)
diff_pred = sum(preds - predictions) / size(valAge, 1)
% the differences are negligible enough to disregard computing a new RMSE
% value

%% Selection of Best Predictors of Age

% normalise data to obtain standardised regression coefficients
normalised_data = normalize(data);

% create corresponding model
model_pred = fitlm(normalised_data, age)
coeff_pred = table2array(model_pred.Coefficients(:, 1));

% put variables in order of magnitude of standardised regression
% coefficients
ordered = sortrows([[1 : 8]' coeff_pred], 2, 'descend', 'ComparisonMethod', 'abs');

% obtain variable names
predictors = string(model.CoefficientNames(ordered(:, 1))');

% display variables in order of magnitude of standarised regression
% coefficients
in_order_of_magnitude = [predictors ordered(:, 1) - 1 ordered(:, 2)]


%% Conclusion
% As mentioned in ANN.m, the relationship between the independent variables
% and the age of abalone do not seem to markedly deviate from a linear one.
% 
% The whole weight instead of the dried shell weight appears to be the best
% predictor of age when taking into account other variables. This means
% that the heavier an abalone is, the more likely it is to be older.
% 
% On the other hand, ShuckedWeight had a comparatively large negative coded
% coefficient, which implies that abalone with more meat are typically
% younger.
% 
% Of all variables, the length of the abalone mattered the least according
% to the standardised regression coefficients. Moreover, the p-value was
% very high at 0.39, which seems to suggest that it is very likely that
% length cannot predict the age of abalone well.
%
% Likewise, height was not very important in determining the age of the
% abalone. In contrast, the diameter, perpendicular to the length of the
% abalone, seemed to be moderately important, which suggests that long
% abalone that are not as wide as they are long are less likely to be old
% while abalone that are rounder are more likely to be old, ceteris
% paribus.
%
% The viscera weight had a negative standardised regression coefficient,
% which implies that abalone with a lighter viscera were older in general,
% which may be a sign that younger abalone have a "healthier" appetite, in
% human terms, or that older abalone were less adept or willing to procure
% food in general.

% The overall model provides a decent estimate of abalone's age, given
% easily measurable features such as the different type of weights and
% dimensional features such as diameter. The relationship seems to be
% largely linear, as ANNs did not produce significantly better results (or
% rather because a single neuron performed similarly well). Nevertheless,
% the ANN created using built-in functions had the lowest RMSE, although
% multiple linear regression performed comparably.