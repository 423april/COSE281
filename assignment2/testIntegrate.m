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
f = @(x) x.^2

% plot the trapezoid integration for  f(x) = x^2

