% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% integrate(function_handle, x_values, h, type) implements numerical
% integration on a known function. The function evaluates the trapezoidal
% or midpoint integral approximation for each pair of successive x-values.
% It returns length(x_values) - 1 values. The function throws an error 
% if the given values do not satisfy h < average_i(x_(i+1) - x_i).
%
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e - 5
%       type: optional, can be 'trapezoid' or 'midpoint' for respective
%             integral approximation rule, if not supplied set to 'trapezoid'
%
%   OUTPUT:
%       integral: array of integrals for each pair of successive x-values, 
%                 number of array elements is length(x_values) - 1
%
%   EXAMPLE: do a trapezoidal integral approximation for f = @(x) x^2, 
%            x_values = [0.001 : 0.1 : 2]. Save the return value to
%            variable integral
%
%       integral = integrate(f, x_values)

function [integral] = integrate(function_handle, x_values, h, type)

% third argument h is optional. if not supplied, set to 1e-5
if ~exist('h', 'var')
    h = 1e-5;
end

% fourth argument type is optional. if not supplied, set to 'trapezoid'
if ~exist('type', 'var')
    type = 'trapezoid';
end

% error handling to guarantee that h < average_i(x_(i+1) - x_i) 
dif_sum = 0;
for k = 1: length(x_values) - 1
    dif_sum = dif_sum + x_values(k+1) - x_values(k);
end
avg_dif = dif_sum/(length(x_values)-1);
assert(h < avg_dif);

% if type == 'trapezoid', do trapezoidal integral approximation
if(strcmp(type, 'trapezoid') == 1)
    area = zeros(1, length(x_values) - 1);
 
 % evaluate the integral for each pair of successive x-values
    for i = 1: length(x_values) - 1
        area(i) = 0;
        for j = x_values(i): h: x_values(i+1)
            area(i) = area(i) + (h ./ 2 .* (function_handle(j + h)+function_handle(j))); 
        end
    end
    
 % return length(x_values)-1 values
    integral = area;
    
% if type == 'midpoint', do midpoint integral approximation
elseif(strcmp(type, 'midpoint') == 1)
        area = zeros(1, length(x_values) - 1);

 % evaluate the integral for each pair of successive x-values
    for i = 1: length(x_values) - 1
        area(i) = 0;
        for j = x_values(i): h: x_values(i+1)
            area(i) = area(i) + (h * function_handle(((j + h) + j)/2));
        end
    end
  % return length(x_values)-1 values
    integral = area;
end





