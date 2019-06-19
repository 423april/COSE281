% COSE281 ENGINEERING MATHEMATICS 2019 FINAL PROJECT
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% pc_analysis.m - perform principal component analysis(PCA) to reduce
%         dimensionality

% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% load abalone data
load abalone.mat

%% Data Manipulation
% separate the dependent and independent variables

% construct full data matrix (the first column, sex, is discarded as it is
% a discrete variable)
data = table2array(abalone(:, 2 : 8));

% obtain labels (age = rings + 1.5)
age = table2array(abalone(:, 9)) + 1.5;


%% Principal Component Analysis

% calculate weights to use for weighted PCA
weights = 1 ./ var(data);

% obtain relevant values
[wcoeff, score, latent, ~, explained] = pca(data, 'VariableWeights', weights);

explained
% note that the first component already describes over 90% of the variance


% get orthogonal eigenvectors
coefforth = inv(diag(std(data))) * wcoeff;

% plot a biplot using the first three principal components, which explain
% more than 97% of the variance
labels = string(abalone.Properties.VariableNames(2:8));
figure('Position', [100 100 500 500]);
biplot(coefforth(:, 1 : 3), 'Scores', score(:, 1 : 3), 'Varlabels', labels);

% The biplot conforms to expectations. Components related to weight and
% components related to the cross-sectional area when viewed top-down are
% clustered together. The observations are largely in line with the
% regression performed in another script.
