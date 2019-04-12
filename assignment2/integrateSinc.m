% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script compares two ways to integrate 
% the sinc-function f(x) = sin(x)/x.
% The two ways are numerical integration and difinite integration
% that uses Tylor series. The integral section is 0.5 to 15. 
% h = 10^[-2:-1:-7] and n = [10: 2: 20]


% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% define h, x_values, n
h = 10^[-2: -1: -7];
x_values = [0.5: 0.1: 15]; % hw guide didn't specify steps so I just gave if 0.1
n = [10: 2: 20];

for i = 1 : length(h)
    num_int(i) = integrate(f, x_values, h(i));
end

for j = 1: length(n)
    def_int(j) = SI(x_values, j);
end

