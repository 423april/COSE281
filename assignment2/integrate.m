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

difsum = 0;
for k = 1: length(x_values) - 1
    difsum = difsum + x_values(k+1) - x_values(k);
end
avgdif = difsum/(length(x_values)-1);
assert(h < avgdif);

% The fourth argument type is a string (or char array) with possible values ‘trapezoid’ and ’midpoint’
% The function should evaluate the integral for each PAIR of SUCCESSIVE x-values 
% and so will return length(x_values)-1 values
if(strcmp(type, 'trapezoid') == 1)
    area = zeros(1, length(x_values) - 1);
    for i = 1: length(x_values) - 1
        % guarantee that h < average_i(x_i+1 - x_i) and throw an error if it doesn’t
        % dif = (x_values(i+1) - x_values(i));
        % assert(h < dif);  % not sure if this is right
        area(i) = 0;
        for j = x_values(i): h: x_values(i+1)
            area(i) = area(i) + (h ./ 2 .* (function_handle(j + h)+function_handle(j))); 
        end
    end
    % return length(x_values)-1 values
    integral = area;
    
elseif(strcmp(type, 'midpoint') == 1)
        area = zeros(1, length(x_values) - 1);
    for i = 1: length(x_values) - 1
        % guarantee that h < average_i(x_i+1 - x_i) and throw an error if it doesn’t
%         dif = x_values(i+1) - x_values(i);
%         assert(h < dif);  % not sure if this is right
        area(i) = 0;
        for j = x_values(i): h: x_values(i+1)
            area(i) = area(i) + (h * function_handle(((j + h) + j)/2));
        end
    end
    integral = area;
end





