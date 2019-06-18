clear all
close all
clc

% import data
load abalone.mat
data = table2array(abalone(:, 2:9));

% shuffle data 
shuffled = data;
perm = randperm(size(data,1));
for i = 1 : size(data,1)
    shuffled(perm(i), :) = data(i,:);
end

% normalize data
ndata = normalize(shuffled);

% devide normalized data set into training set and test set
train = ndata(1 : round(size(ndata, 1) * 0.7), :);
test = ndata(round(size(ndata, 1) * 0.7) + 1 : size(ndata,1), :);

% use normalized data to calculate model
ncoeff = [ones(size(train, 1), 1) train(:,1:7)]\train(:,8)

% devide original data set into training set and test set
train = shuffled(1 : round(size(shuffled, 1) * 0.7), :);
test = shuffled(round(size(shuffled, 1) * 0.7) + 1 : size(shuffled,1), :);

% calculate model
coeff = [ones(size(train, 1), 1) train(:,1:7)]\train(:,8);

% calculate mse and sse on test set
pred = [ones(size(test,1), 1) test(:, 1:7)] * coeff;
mse = sum((test(:,8) - pred) .^ 2) / size(test,1)
sse = sum((test(:,8) - pred) .^ 2)


% linear regression using matlab internal function
lm = fitlm(ndata(:, 1:7), ndata(:,8))

%% Data Analysis
% In the data above, we predicted the number of rings an abalone will have.
% The number of rings +1.5 gives the abalone's age in years. From now on,
% we will consider number of rings and age are the same thing. 

% Which of the features are good/meaningful/powerful in our analysis?

% In the linear model, if the data is normalized(all in same scale) 
% a coefficient has a larger absolute value than the others, the
% corresponding feature has a powerful relationship with the output. 
% In our model, the whole weight had a positive large coefficient meaning
% that the heavier the abalone is, the older it is. Also, the shucked
% weight had a negatively large coefficient meaning that the heavier the
% meat is, the younger the abalone is. Thus, whole weight and shucked
% weight are powerful features.
% Diameter and Shell weight also have significantly high positive 
% coefficient values. These are meaningful features in predicting age.
% The length had a very small coefficient, and high p-value, that means
% length is not a meaningful feature in determining the age of the abalone.

% From the linear model we made, we can infer that older abalone have
% heavier shells with large diameters. Furthermore, as abaolne grow old,
% they tend to loose weigth in meat and gut. 
