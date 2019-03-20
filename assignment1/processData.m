% ENGINEERING MATHEMATICS ASSIGNMENT 1 PROBLEM #3
% STUDENT ID: 2015320143, 2016320128, 2018320250
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
% gets each column
c1 = data(:,1);
c2 = data(:,2);
c3 = data(:,3);
c4 = data(:,4);
c5 = data(:,5);
c6 = data(:,6);
c7 = data(:,7);
c8 = data(:,8);
c9 = data(:,9);
c10 = data(:,10);
c11 = data(:,11);
c12 = data(:,12);
c13 = data(:,13);
c14 = data(:,14);
 
%creates figure
f3 = figure(3);
set(f3, 'Units', 'pixels', 'Position', [0 0 1000 1000]);
 
%subplots
subplot(3,5,1);
scatter(c1,c14);
title('Column 1');
 
 
subplot(3,5,2);
scatter(c2,c14);
title('Column 2');
 
subplot(3,5,3);
scatter(c3,c14);
title('Column 3');
 
subplot(3,5,4);
scatter(c4,c14);
title('Column 4');
 
subplot(3,5,5);
scatter(c5,c14);
title('Column 5');
 
subplot(3,5,6);
scatter(c6,c14,[],'r');
title('Column 6');
 
subplot(3,5,7);
scatter(c7,c14);
title('Column 7');
 
subplot(3,5,8);
scatter(c8,c14,[],'r');
title('Column 8');
 
subplot(3,5,9);
scatter(c9,c14);
title('Column 9');
 
subplot(3,5,10);
scatter(c10,c14);
title('Column 10');
 
subplot(3,5,11);
scatter(c11,c14);
title('Column 11');
 
subplot(3,5,12);
scatter(c12,c14);
title('Column 12');
 
subplot(3,5,13);
scatter(c13,c14,[],'r');
title('Column 13');
 
sgtitle('Comparison of Each Col with Col 14');


% We believe that columns 6, 8 and 13 have the most explanatory power for 
% determining the final column (column 14) of data. We plotted 13 scatter
% plots with column 14 as the y-axis and each column as x-axis. According
% to the scatter plots shown on the figure, columns 6 & 8 show a positive 
% correlation with column 14 and column 13 a negative correlation. Other
% columns do not seem to have a clear and consistent trend with column 14 
% or has too many outliers. 
