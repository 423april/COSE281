clear all
close all
clc

load abalone.mat
data = table2array(abalone(:, 2:9));
data = normalize(data);
shuffled = data;
perm = randperm(size(data,1), round(size(data,1)*0.7));
% for i = 1 : size(data,1)
%     shuffled(perm(i), :)
lm = fitlm(data(:,1:7), data(:, 8))
coeff = table2array(lm.Coefficients(:, 1));
pred = [ones(size(data, 1), 1) data(:, 1:7)] * coeff;
sse = sum((data(:, 8) - pred) .^ 2) / 4177;

newdata = data(:, 2:8);
lm = fitlm(newdata(:,1:6), newdata(:, 7))

plot(lm)


