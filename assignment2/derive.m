% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% derive(function_handle, x_values, h) implements numerical derivation on a
% known function using the standard numerical approximation of the
% derivative, f'(x) = (f(x + h) - f(x)) / h, with h very small.
%   
%   INPUT:
%       function_handle: the function to differentiate
%       x_values: array of x values
%       h: optional, set to h = 1e-5 if not supplied
%
%   OUTPUT:
%       derivative: an array of standard numerical approximations of the
%                   derivative of the function for the given set of
%                   x_values
%
%   EXAMPLE: perform numerical differentiation of f = @(x) x^2, 
%            given x_values = [0.001 : 0.1 : 2] & h = 1e-5,
%            then save the results into the variable derivative
%
%       derivative = derive(f, x_values, h);

function [derivative] = derive(function_handle, x_values, h)

% use h = 1e-5 if only two arguments are passed to the function
if nargin == 2
    h = 1e-5;
end

% using function_handle and x_values, calculate the derivative numerically
% for some small h, then save the results of the operation into an array
derivative = (function_handle(x_values + h) - function_handle(x_values)) / h;

end
