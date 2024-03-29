% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
%
%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: housingDescription.txt
%
% Auto-generated by MATLAB on 10-May-2019 17:14:21

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ":";

% Specify column names and types
opts.VariableNames = ["CategoryNames", "Description"];
opts.VariableTypes = ["string", "string"];
opts = setvaropts(opts, [1, 2], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
housingDescription = readtable("housingDescription.txt", opts);


%% Clear temporary variables
clear opts
