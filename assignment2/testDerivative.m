% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script plots the SSE for all points summed up for 
% h = 10^[-1 : -1 :-14] and x_values = [0.001 : 0.01 : 2] for 
% the derivatives of following functions: f(x) = x^2, f(x) = cos(x), 
% f(x) = sin(x)/x.


% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% define variables h and x_values
h = 10.^[-1 : -1 : -14];
x_values = [0.001 : 0.01 : 2];

% define symbol x
syms x

% define f as x^2
f = @(x) x.^2;

% go through each element and calculate SSE of all points
% f'(x) = 2x
for i = 1 : length(h)
    err(i) = sum((2 * x_values - derive(f, x_values, h(i))).^2);
end

% plot err in a LOG plot
semilogy(err)

% display grid lines, label x & y-axes, and retain plot in current axes
grid on
xlabel('h'); 
ylabel('SSE [log scale]');
hold on

% define f2 as cos(x)
f2 = @(x) cos(x)

% go through each element and calculate SSE of all points
% f2'(x) = -sin(x)
for i = 1 : length(h)
    err2(i) = sum((-1 * sin(x_values) - derive(f2, x_values, h(i))).^2);
end

% plot err2 
semilogy(err2)

% define f3 as sin(x) / x and g as derivative of f3, 
% g(x) = f3'(x) = (x * cos(x) - sin(x)) / x^2
f3 = @(x) sin(x)./ x
g = @(x) (x .* cos(x) - sin(x)) ./ (x .^ 2);

% go through each element and calculate SSE of all points
for i = 1 : length(h)
    err3(i) = sum((g(x_values) - derive(f3, x_values, h(i))).^2);
end

% plot err3 
semilogy(err3)

% shows which line is which function's error curve
legend({'x^2','cosx', 'sinx/x'},'location','northeast')

% Questions
% 1) Why do the error curves first go down then up again?
%   At first, as the size of h decreases, the error of the derivative
%   decreases. But after a h = 10^(-8), the computer cannot properly
%   compute the small numbers. This is because the computer handles double
%   values by formulaic representation, which leads to floating point
%   error. We cannot acheive a derivative with error less than 10^(-14)
%   because of this error. 
% 2) Why do you think that the error curves for the three functions are
% different? 
%   
