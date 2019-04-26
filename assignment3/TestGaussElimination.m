% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 3 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script generates random matrices and vectors with size 5, 10, 100,
% 500. It compares the execution time between the function GaussElimination, 
% and the built-in Matlab operator '\'.


% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

sz = [5, 10, 100, 500];
UserMade = zeros(1,4);
BuiltIn = zeros(1,4);
for i = 1 : 4
    % generate random matrices and vectors of given sizes.
    a = sz(i);
    M = rand(a);
    V = rand(a, 1);
    
    % measure execution time of GaussElimination function
    tic
    x = GaussElimination(M,V);
    UserMade(i) = toc;
    
    % measure execution time of built-in operator '\'
    tic
    x = M\V;
    BuiltIn(i) = toc;
end

% for the given problem sizes, records the execution time 
% for each solution method and plots the results in a nice plot.
plot(sz, UserMade);
hold on
plot(sz, BuiltIn);

% display grid lines and label the x & y-axes
grid on
xlabel('size of data'); 
ylabel('execution time[seconds]');
legend({'UserMade','BuiltIn'},'location','northeast')


% Question c) How much faster is the built-in Matlab function 
% than your function for each time step? Why do you think it is faster?
% On one trial, the user defined function takes each 0.0252, 0.0083, 0.0033, 0.2945
% seconds more than the built-in function for each size 5, 10, 100, 500.
% You can see that as the matrix, vector size increases, the execution time
% difference becomes greater. The '\' operator in Matlab uses several other
% solving algorithms to solve the linear equation, such as the LU solver,
% the triangular solver, and so on. This allows Matlab to solve a linear
% equation in an effective way, resulting in superior execution time.

