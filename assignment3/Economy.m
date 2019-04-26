% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 3 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script sets up, solves, and prints out the solution to the following 
% economy problem using GaussElimination.
% S : steel, E : energy, C : cars deparment investment[dollars].
% 0.1*S + 0.65*E + 0.05*C = 10*10^9 dollar's worth steel product
% 0.04*S + 0.2*E + 0.1*C = 15*10^9 dollar's worth energy product
% 0.6*S + 0.2*E + 0.05*C = 20*10^9 dollar's worht car product


% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% create internal demand M, final demands b
M = [[0.1 0.65 0.05];[0.04 0.2 0.1]; [0.6 0.2 0.05]];
b = 10^9 * [10; 15; 20];

% find solution using GaussElimination
x = GaussElimination(M, b);

% Questions
% 1) Why do the numbers in 1), 2), 3) not add up to US$1?
%    The numbers in 1), 2), 3) are coefficients of a linear equation. The
%    multiplication of the investment and coefficient all sumed would add
%    up to US$1.
% 2) Does the solution X add up to the sum of the final demand? If not, why not?
%    The solution x does not add up to the sum of the final demand. 


