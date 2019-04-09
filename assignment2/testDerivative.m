% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script plots the SSE for all points summed up for h = 10^[-1 : -1 :
% -14] and x_values = [0.001 : 0.01 : 2] for the following functions: 
% f(x) = x^2, f(x) = cos(x), f(x) = sin(x)/x.


% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% define variables h and x_values
h = 10.^[-1 : -1 : -14];
x_values = [0.001 : 0.01 : 2];

% derive(x^2)
syms x
f = @(x) x.^2

for i = 1 : length(h)
    err(i) = sum((2 * x_values - derive(f, x_values, h(i))).^2);
end
semilogy(err)

f2 = @(x) cos(x)

for i = 1 : length(h)
    err2(i) = sum((-1 * sin(x_values) - derive(f2, x_values, h(i))).^2);
end
semilogy(err2)

f3 = @(x) sin(x) / x

g = @(x) (x .* cos(x) - sin(x)) ./ (x .^ 2);
for i = 1 : length(h)
    err3(i) = sum((g(x_values) - derive(f3, x_values, h(i))).^2);
end
semilogy(err3)
