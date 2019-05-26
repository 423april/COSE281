% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% testOneLayer.m loads the data from testData.txt, changes the class-labels
% to 0 and 1, then learns the two classes using a one-hidden-layer neural
% network with the logistic activation function.

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all
clear all
clc

% load the data from testData.txt and change the labels
getTestData;
testData = table2array(testData);
labels = ~(testData(:, 3) - 1);

% initialise a set of random weights for a neural network with a hidden
% layer of dimensionality 3
% note that the last column represents the bias
weights{1} = randn(3, 3);
weights{2} = randn(1, 4);

%% train for 10000 epochs with a learning rate of .01
% use stochastic gradient descent
for epoch = 1 : 10000
    % perform stochastic gradient descent
    for i = 1 : 200
        % select a random point from the 200 datapoints
        index = floor(rand * size(testData, 1)) + 1;
        
        % update weights, with a learning rate of 0.01
        weights = backprop_faulty(testData(index, 1 : 2), weights, labels(index), 0.01, 'logistic', 'logistic');
    end
end

%% create subplot using original data
subplot(1, 2, 1);

% determine which class the points belong to
cross_org = [testData(labels == 0, 1) testData(labels == 0, 2)];
circle_org = [testData(labels == 1, 1) testData(labels == 1, 2)];

% create scatter plot
scatter(cross_org(:, 1), cross_org(:, 2) , 'r', 'x')
hold on
scatter(circle_org(:, 1), circle_org(:, 2), 'g')
title('Original')

%% create subplot using predictions
subplot(1, 2, 2);

% obtain predictions using trained weights
output = feed_forward_faulty(testData(:, 1 : 2), weights, 'logistic');

% predict which class the points belong to
cross_pred = [testData(output{2} < 0.5, 1) testData(output{2} < 0.5, 2)];
circle_pred = [testData(output{2} > 0.5, 1) testData(output{2} > 0.5, 2)];

% create scatter plot for predictions
scatter(cross_pred(:, 1), cross_pred(:, 2), 'r', 'x')
hold on
scatter(circle_pred(:, 1), circle_pred(:, 2), 'g')
title('Predicted')