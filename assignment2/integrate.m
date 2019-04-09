% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% integrate
%
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e - 5
%       type:
%   OUTPUT:
%       integral: 
%
%   EXAMPLE: 

function [integral] = integrate(function_handle, x_values, h, type)

% if we only have two input arguments, fall back to default
if ~exist('h', 'var')
    h = 1e-5;
end
if ~exist('type', 'var')
    type = 'trapezoid';
end


% this does the job also for arrays of inputs

if(strcmp(type, 'trapezoid') == 1)
    area = 0;
    for x = 1: length(x_values)
        area = area + (x_values(x+1)-x_vlaues(x))/2*(function_handle(x_values(x+1))+f(x_values(x))); 
    end
    integral = area;
elseif(strcmp(type, 'midpoint') == 1)
    area = 0;
    for x = 1: length(x_values)
        area = area + ((x_values(x+1) - x_values(x)) * function_handle((x_values(x+1) + x_values(x))/2));
    end
    integral = area;
end





