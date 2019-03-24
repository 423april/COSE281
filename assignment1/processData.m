% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 1 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script loads dataForTesting.mat. Then, it calls the fixData function
% to clean the data. After cleaning data, the script plots 13 scatter plots
% based on the data. 


% close all figures, clear the workspace and output window of Matlab.
clear all
close all
clc

% load dataForTesting.mat
load dataForTesting

% fix data
data = fixData(data);

% create figure
f3 = figure(3);
set(f3, 'Units', 'pixels', 'Position', [0 0 1000 1000]);
 
% define which columns should be red (explanation for choices below).
red_col = [6 8 13];

% create subplots accordingly.
for x = 1 : 1 : 13
    % create subplots in a 3-by-5 grid.
	subplot(3, 5, x);
	if ismember(x, red_col)
    	scatter(data(:, x), data(:, 14), 'r');
	else
    	scatter(data(:, x), data(:, 14));
	end
	title("Column " + num2str(x));
end
 
sgtitle('Comparisons of Columns 1 to 13 with Column 14')

% We believe that columns 6, 8 and 13 have the most explanatory power for
% determining the final column of data (column 14). We plotted 13 scatter
% plots with column 14 as the y-axis and the other columns as the x-axes.
% As can be seen from the scatter plots shown on the figure, columns 6 & 8
% show a positive correlation with column 14 and column 13 a negative
% correlation. Other columns do not seem to have a clear and consistent
% trend with column 14 or has too many outliers.

