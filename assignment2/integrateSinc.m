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

% define f as a symbolic function of x.
syms x
f = @(x) sin(x) / x;

% define h, x_values and n
h = 10.^[-2: -1: -7];
x_values = [0.5: 0.1: 15];
x = [0.5 15];
n = [10: 2: 20];
si = zeros(2, 6);

% calculate using the first method
for i = 1 : length(h)
    si(1, i) = sum(integrate(f, x_values, h(i), "midpoint"));
end

% calculate using the second method
for i = 1 : length(n)
    si(2, i) = SI(x, n(i));
end

% plot necessary plots
subplot(1, 2, 1);
scatter(n, si(1, :));

subplot(1, 2, 2);
scatter(h, si(2, :));

% Question
% 1) Which method would you choose and why?
%   The second way is more preferrable as the errors are smaller earlier.
%   Moreover, the amount of calculation required is immensely less.
