% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 3 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script generates random square matrices and column vectors of order
% and number of elements n = 5, 10, 100 and 500 respectively. The script
% compares the execution time between the function GaussElimination, and
% the built-in Matlab operator '\'.

% clear the workspace, close all figures and clear the output window 
% of Matlab
clear all
close all
clc

% set sizeArray and preallocate executionTimes
sizeArray = [5 10 100 500];
executionTimes = zeros(4,2);

for i = 1 : size(sizeArray, 2)
    % generate random matrices and vectors of given sizes
    sz = sizeArray(i);
    A = rand(sz);
    b = rand(sz, 1);
    
    % measure and record execution times of the GaussElimination function
    tic
    GaussElimination(A, b);
    executionTimes(i, 1) = toc;
    
    % measure and record execution times of built-in operator '\'
    tic
    A\b;
    executionTimes(i, 2) = toc;
end

% plot the results in a nice plot
plot(sizeArray, executionTimes(:, 1))
hold on
plot(sizeArray, executionTimes(:, 2))

% display grid lines and label the x & y-axes
grid on
xlabel('order of square matrix')
ylabel('execution time /s')
legend({'User-made','Built-in'},'location','northeast')

% Question
% c) How much faster is the built-in Matlab function than your function for
% each time step? Why do you think it is faster?
%   On one trial, GaussElimination took 0.0098s, 0.0027s, 0.0058s and
%   0.1639s longer than the built-in operator '\' for n = 5, 10, 100 and
%   500 respectively. Matlab attempts to optimise the execution time for
%   the operation depending on the nature of the inputs, such as whether
%   the input arrays are dense or sparse, if the first input is triangular
%   etc. as shown in the documentation. This allows the operation to adapt
%   to the situation and save a lot of time, especially as the input sizes
%   increase.

