% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 1 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% This script loads dataForTesting.mat.Then, it calls fixData function to
% clean the data. After cleaning data, the script plots 13 scatter plots
% based on the data. 

% code to clear all workspace, all figures and output window of Matlab
clear all
close all
clc
 
% command to load dataForTesting.mat
load dataForTesting
data = fixData(data);
%creates figure
f3 = figure(3);
set(f3, 'Units', 'pixels', 'Position', [0 0 1000 1000]);
 
%subplots
red_col = [6 8 13];

for x = 1:1:13
	subplot(3,5,x);
	if ismember(x, red_col)
    	scatter(data(:,x),data(:,14),[], 'r');
	else
    	scatter(data(:,x),data(:,14));
	end
	title("Column " + num2str(x));
end
 
sgtitle('Comparison of Each Col with Col 14')

% We believe that columns 6, 8 and 13 have the most explanatory power for 
% determining the final column (column 14) of data. We plotted 13 scatter
% plots with column 14 as the y-axis and each column as x-axis. According
% to the scatter plots shown on the figure, columns 6 & 8 show a positive 
% correlation with column 14 and column 13 a negative correlation. Other
% columns do not seem to have a clear and consistent trend with column 14 
% or has too many outliers. 

