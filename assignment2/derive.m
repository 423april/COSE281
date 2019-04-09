% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% derive 
%
%   
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e - 5
%
%   OUTPUT:
%       derivative: 
%
%   EXAMPLE: 

function [derivative] = derive(function_handle, x_values, h)

% if we only have two input arguments, fall back to default
if (nargin == 2)
    h = 1e - 5;
end
% this does the job also for arrays of inputs
derivative = (f(x + h)-f(x))/h;




