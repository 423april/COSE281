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
% use auto-generated function from Import Wizard: makeDescTable.m
makeDescTable;

% split the data into 13 predictor variables pred [the first 13 columns of 
% data] and 1 target variable price [the 14th column of the data]
pred = data(:, 1:13);
price = data(:, 14);




