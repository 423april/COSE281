% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script compares two ways of integrating the sinc-function, f(x) =
% sin(x) / x. The first way is numerical integration while the second way
% uses the approximate Taylor series of the integral.
% The interval of integration is [0.5, 15].
% Note that h = 10^[-2:-1:-7] and n = [10: 2: 20].

% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% define f as a symbolic function of x
syms x
f = @(x) sin(x) / x;

% define h, n and x_values
h = 10.^[-2: -1: -7];
n = [10: 2: 20];
x_values = [0.5: 0.1: 15];

% define x, which represents the interval of integration
x = [0.5 15];

% preallocate si, the results of the integration operations using both
% methods
si = zeros(2, 6);

% integrate using integrate() and store the results in the first row of si
for i = 1 : length(h)
    si(1, i) = sum(integrate(f, x_values, h(i), "midpoint"));
end

% integrate using SI() and store the results in the second row of si
for i = 1 : length(n)
    si(2, i) = SI(x, n(i));
end

% plot results of using the first method
subplot(1, 2, 1);
scatter(h, si(1, :));
% label x-axis as h
xlabel('h');

% plot results of using the second method
subplot(1, 2, 2);
scatter(n, si(2, :));
% label x-axis as n
xlabel('n');

% Question
% 1) Which method would you choose and why?
%   The first method is preferable as the errors are significantly smaller
%   even for larger values of h, whereas the method which uses the Taylor
%   series approximation requires the Taylor approximation to be of a high
%   degree (at least n = 18) in order to obtain results with small errors.
