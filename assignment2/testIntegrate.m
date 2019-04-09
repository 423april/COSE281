% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script plots the SSE for all points summed up for h = 10^[-2 : -1 :
% -7] and x_values = [0.001 : 0.1 : 2] for both trapezoidal and midpoint
% integral approximations of the following function: f(x) = x^2 

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

% definite integral of x^2 is x^3/3 
% go through each element and calculate SSE of all points for trapezoidal
% integral approximation
for i = 1 : length(h)
    trap_err(i) = sum((((x_values .^ 3) ./3) - integrate(f, x_values, h, 'trapezoid')).^2);
end

% plot trap_err
semilogy(trap_err) 

% display grid lines, label x & y-axes, and retain plot in current axes
grid on
xlabel('h'); 
ylabel('SSE [log scale]');
hold on

% go through each element and calculate SSE of all points for midpoint
% integral approximation
for i = 1 : length(h)
    mid_err(i) = sum((((x_values .^ 3) ./3) - integrate(f, x_values, h, 'midpoint')).^2);
end

% plot trap_err
semilogy(mid_err)

% Questions
% 1) What happens to the error curves as h becomes smaller and why?
% 2) Which integration method is better? 
