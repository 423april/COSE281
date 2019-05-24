% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #2lo
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% testOneLayer.m loads the data from testData.txt, changes the class-labels
% to 0 and 1, and learns the two classes using a one-hidden layer neural
% network with the logistic activation function.

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all
clear all
clc

% load the data from testData.txt
getTestData;

