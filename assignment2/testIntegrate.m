% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% testIntegrate.m:
% This script plots the SSE for all points summed up for h = 10^[-2 : -1 :
% -7] and x_values = [0.001 : 0.1 : 2] for the following function: 
% f(x) = x^2 for both trapezoid and midpoint integration.

% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% define variables h and x_values
h = 10.^[-2 : -1 : -7];
x_values = [0.001 : 0.1 : 2];

% define symbol x and function f
syms x
f = @(x) x.^2;

% compute the definite integral for function x^2, with interval 0.001 to 2
for k = 1 : length(x_values) - 1
    defint(k) = x_values(k + 1) .^3 .*(1/3) - x_values(k) .^3 .*(1/3);
end

% plot the trapezoid integration for  f(x) = x^2
for i = 1 : length(h)
    err1(i) = sum((defint - integrate(f, x_values, h(i), 'trapezoid')).^2);
end
% plots err1 in a LOG plot
 semilogy(err1);

% display grid lines, label x & y-axes, and retain plot in current axes
grid on
xlabel('h'); 
ylabel('SSE [log scale]');
hold on;

for i = 1 : length(h)
    err2(i) = sum((defint - integrate(f, x_values, h(i), 'midpoint')).^2);
end
% plots err2 in a LOG plot
 semilogy(err2);

% shows which line is which function's error curve
legend({'trapezoid','midpoint'},'location','northeast')

% Questions
% 1) What happens to the error curves as h becomes smaller and why?
%   As h becomes smaller, the error decreases. This is because as h
%   decreases, the excessive amount of area that the function calculates
%   also decreases. Thus, the function becomes more precise and the error
%   decreases.
% 2) Which integration method is better?
%   Although the graph doesn't seem to show the difference of the two SSEs'
%   on first sight, when you use the magnifying tool and look closer, there
%   are two lines. The trapezoidal integration method has slightly 
%   higher error than the midpoint integration method. 
%   Thus, the midpoint integration method is better.

