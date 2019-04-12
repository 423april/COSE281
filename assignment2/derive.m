% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% derive(function_handle, x_values, h) implements numerical derivation on a
% known function using the standard numerical approximation of the
% derivative, f'(x) = (f(x+h) - f(x)) / h, with h very small.
%   
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e-5
%
%   OUTPUT:
%       derivative: an array of standard numerical approximation of the
%                   derivative for x_values
%
%   EXAMPLE: do a numerical derivation for f = @(x) x^2,  
%            x_values = [0.001 : 0.1 : 2] & h = 10^[-1 : -1 : -14]
%            and save the result to variable derivative
%
%       derivative = derive(f, x_values, h);

function [derivative] = derive(function_handle, x_values, h)

% if we only have two input arguments, fall back to default
if (nargin == 2)
    h = 1e-5;
end

% For given input function_handle and x_values, calculates the derivative
% with small steps h, and returns an array of numerical derivatives.
% this does the job also for arrays of inputs
derivative = (function_handle(x_values + h) - function_handle(x_values)) / h;

end
