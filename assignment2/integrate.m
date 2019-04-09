% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% integrate(function_handle, x_values, h, type) implements numerical
% integration on a known function. The function evaluates the approximate 
% integral for each pair of successive x-values using trapezoid or midpoint
% rule. It returns length(x_values) - 1 values. 
% If h >= average_i (x_(i+1) - x_i), the function throws an error.
%
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e - 5
%       type: optional, can be 'trapezoid' or 'midpoint' for respective
%             integration rule, if not supplied set to 'trapezoid'
%
%   OUTPUT:
%       integral: array of integrals for each pair of successive x-values, 
%                 number of array elements is length(x_values) - 1
%
%   EXAMPLE: do a trapezoidal derivation for f = @(x) x^2, 
%            x_values = [0.001 : 0.1 : 2]. Save the return value to
%            variable integral
%
%       integral = integrate(f, x_values)

function [integral] = integrate(function_handle, x_values, h, type)

% third argument h is optional. if not supplied, set to 1e-5
if ~exist('h', 'var')
    h = 1e-5;
end

% fourth argument type is optional. If not supplied, set to 'trapezoid'
if ~exist('type', 'var')
    type = 'trapezoid';
end

% if type == 'trapezoid', use trapezoid rule to approximate the integral
if(strcmp(type, 'trapezoid') == 1)
    for i = 1: length(x_values) - 1
        % guarantee that h < average_i(x_i+1 - x_i) and throw an error if it doesn’t
        assert(h < x_values(i+1) - x_values(i));  % not sure if this is right
        
        % evaluate the integral for each PAIR of SUCCESSIVE x-values 
        area(x) = (x_values(i+1)-x_vlaues(i))/2*(function_handle(x_values(i+1))+f(x_values(i))); 
    end
    % return length(x_values)-1 values
    integral = area;
    
% if type == 'midpoint', use midpoint rule to approximate the integral
 elseif(strcmp(type, 'midpoint') == 1)
    for i = 1: length(x_values) - 1
        assert(h < x_values(i+1) - x_values(i));
        area(x) = area + ((x_values(i+1) - x_values(i)) * function_handle((x_values(i+1) + x_values(i))/2));
    end
    integral = area;
end





