% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 3 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script sets up, solves and prints out the solution to the following 
% economy problem using GaussElimination.
% 
% 1) The production of a dollar’s worth of cars requires an input of
% $0.6 from the steel sector, $0.2 from the energy sector, and $0.05 from
% the car sector.
% 2) The production of a dollar’s worth of energy requires an input of
% $0.2 from the energy sector and $0.04 from the steel sector and $0.1 from
% the car sector.
% 3) The production of a dollar’s worth of steel requires an input of
% $0.1 from the steel sector, $0.65 from the energy sector, and $0.05 from
% the car sector.

% clear the workspace, close all figures and clear the output window 
% of Matlab
clear all
close all
clc

% create internal demand M, final demand b
M = [0.1 0.04 0.6; 0.65 0.2 0.2; 0.05 0.1 0.05];
b = [10; 15; 20];

% find solution using GaussElimination
X = GaussElimination(eye(3) - M, b)

% Questions
% 1) Why do the numbers in 1), 2), 3) not add up to US$1?
%    The $1 represents the revenue whereas the differences between $1 and
%    the sum of numbers in 1), 2) and 3) respectively represent the profit.
%    Hence the numbers in 1), 2) and 3) should not add up to US$1 if the
%    producer wants to profit from the production of $1's worth of a
%    particular good.
% 2) Does the solution X add up to the sum of the final demand? If not, why
% not?
%    X does not add up to the sum of the final demand b as X includes the
%    internal demands in creating the products required as in the final
%    demand.