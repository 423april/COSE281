% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% derive Check and fix data input with some error handling.
%   fixData(DATA) checks if the data input conforms to the expected
%   dimensions of 206-by-14 and fixes the input such that all values in the
%   data are positive or 0 by deleting rows with negative or NaN values.
%   
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e - 5
%
%   OUTPUT:
%       derivative: 
%
%   EXAMPLE: Fix the data in variable DATA and save the output back into
%            DATA.
%
%       DATA = fixData(DATA);

function [derivative] = derive(function_handle, x_values, h)

% if we only have two input arguments, fall back to default
if (nargin == 2)
    h = 1e-5;
end
% this does the job also for arrays of inputs
derivative = (function_handle(x_values + h)-function_handle(x_values))/h;




