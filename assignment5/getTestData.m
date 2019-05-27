% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
%

%% Import data from text file
% getTestData.m for importing data from the following text file:
%
%    filename: testData.txt
%
% Auto-generated by MATLAB on 24-May-2019 17:25:22

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["x", "y", "label"];
opts.VariableTypes = ["double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
testData = readtable("testData.txt", opts);


%% Clear temporary variables
clear opts