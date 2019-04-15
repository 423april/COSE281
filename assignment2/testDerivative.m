% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script plots the SSE for all points summed up for 
% h = 10^[-1 : -1 :-14] and x_values = [0.001 : 0.01 : 2] for the
% derivatives of following functions found using standard numerical
% approximations and their hand-derived derivatives: 
% f(x) = x^2, f(x) = cos(x) and f(x) = sin(x) / x.

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

% define f, the cell array of function handles of functions that are to be
% differentiated
f = {@(x) x.^2, @(x) cos(x), @(x) sin(x) ./ x};

% define g, the cell array of function handles of the corresponding
% hand-derived differentiations of the functions in f
g = {@(x) 2 * x, @(x) -1 * sin(x), @(x) (x .* cos(x) - sin(x)) ./ (x .^ 2)};

% preallocate sse, the array containing the SSE of all points for each
% element in h for each function
sse = zeros(length(f), length(h));

% calculate the SSEs and plot the results on a semi-log graph
for i = 1 : length(f)
    for j = 1 : length(h)
        sse(i, j) = sum((g{i}(x_values) - derive(f{i}, x_values, h(j))).^2);
    end
    semilogy(sse(i, :))
    hold on
end

% display grid lines and label the x & y-axes
grid on
xlabel('h'); 
ylabel('SSE [log scale]');

% label the error curves of each function accordingly
legend({'x^2','cosx', 'sinx/x'},'location','northeast')

% Questions
% 1) Why do the error curves first go down then up again?
%   Initially, as h decreases, the error of the approximations decrease as
%   h becomes more representative of an infinitesimally small h. However,
%   beyond h = 10^(-8), the inaccuracy of floating point arithmetic impacts
%   the accuracy of the approximation, as the precision is limited by the
%   size of the variables, which means the method used precludes the proper
%   handling of smaller values. In fact, as h becomes smaller than 10^(-8),
%   the loss and distortion of information increases, which ultimately
%   results in the error increasing. Hence, we cannot achieve a derivative
%   with error less than 10^(-15).
% 2) Why do you think that the error curves for the three functions are
% different? 
%   The errors are arbitrary values as the accuracy and precision of
%   floating point calculations are limited. Moreover, computing sin(x) and
%   cos(x) requires 
%   
