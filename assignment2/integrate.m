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

% The third argument h should be optional
% The fourth argument type should be optional. If not supplied, set to
% 'trapezoid'.
if ~exist('h', 'var')
    h = 1e-5;
end
if ~exist('type', 'var')
    type = 'trapezoid';
end


% The fourth argument type is a string (or char array) with possible values ‘trapezoid’ and ’midpoint’
% The function should evaluate the integral for each PAIR of SUCCESSIVE x-values 
% and so will return length(x_values)-1 values
if(strcmp(type, 'trapezoid') == 1)
    for x = 1: length(x_values) - 1
        % guarantee that h < average_i(x_i+1 - x_i) and throw an error if it doesn’t
        assert(h < x_values(x+1) - x_values(x));  % not sure if this is right
        
        % evaluate the integral for each PAIR of SUCCESSIVE x-values 
        area(x) = (x_values(x+1)-x_vlaues(x))/2*(function_handle(x_values(x+1))+f(x_values(x))); 
    end
    % return length(x_values)-1 values
    integral = area;
    
elseif(strcmp(type, 'midpoint') == 1)
    for x = 1: length(x_values) - 1
        assert(h < x_values(x+1) - x_values(x));
        area(x) = area + ((x_values(x+1) - x_values(x)) * function_handle((x_values(x+1) + x_values(x))/2));
    end
    integral = area;
end





