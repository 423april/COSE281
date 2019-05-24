% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% gradientTestFunction.m calls the function gradient_descent and outputs 
% the results for [xoptimal,foptimal,niterations]

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all
clear all
clc

% define the variables to test the function
f = @(x1,x2) x1.^2 + x1.*cos(x1.*x2/3) + 3*x2.^2;
xstart = [10 10]'; 
lambda = 0.03; 
tolerance = 1e-7;
maxiter = 1000;

% define the partial derivatives of f
g1 = @(x1,x2) -(1/3) * x1 .* x2 .* sin(x1 .* x2/3) + cos(x1.*x2/3) + 2*x1;
g2 = @(x1,x2) 6 * x2 - 1/3 * x1 .^2 .* sin(x1 .* x2/3);

% call the functions and get results 
[xoptimal,foptimal,niterations] = gradient_descent(f,g1,g2,xstart,lambda,tolerance,maxiter)


%% Question
%   If your step size is too large, the optimization will not converge. 
%   What is the value of lambda up to two digits that will result in
%   non-convergence? Try this out yourself and insert the value of lambda 
%   into the script.
% try lambda = 0.34 results in nan 0.33 doesn't % not sure

lambda1 = 0.34;
[xopt1,fopt1,niter1] = gradient_descent(f,g1,g2,xstart,lambda1,tolerance,maxiter);



%% Question
%   If you make larger steps, you could reach the minimum faster. What is 
%   the value of lambda that has the minimum number of steps in order to 
%   reach the minimum point? Try this out yourself and insert the value of 
%   lambda into the script.
% 0.24 = 31 % not sure

lambda2 = 0.24;
[xopt2,fopt2,niter2] = gradient_descent(f,g1,g2,xstart,lambda2,tolerance,maxiter);
