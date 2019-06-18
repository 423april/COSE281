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

pred = [ones(size(test,1), 1) test(:, 1:7)] * ncoeff;
mse = sum((test(:,8) - pred) .^ 2) / size(test,1);

% devide data set into training set and test set
train = shuffled(1 : round(size(shuffled, 1) * 0.7), :);
test = shuffled(round(size(shuffled, 1) * 0.7) + 1 : size(shuffled,1), :);

% calculate model
coeff = [ones(size(train, 1), 1) train(:,1:7)]\train(:,8);

% calculate mse and sse on test set
pred = [ones(size(test,1), 1) test(:, 1:7)] * coeff;
mse = sum((test(:,8) - pred) .^ 2) / size(test,1)
sse = sum((test(:,8) - pred) .^ 2)

