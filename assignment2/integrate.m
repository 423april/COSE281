% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% integrate(function_handle, x_values, h, type) implements numerical
% integration using trapezoidal and midpoint approximation. 
%
%   INPUT:
%       function_handle: variable representing function
%       x_values: array of x values
%       h: optional, if not supplied should be set to h = 1e - 5
%       type: If 'trapezoid' the function needs to implement 
%              trapezoidal approximation of the integral values, 
%              If type is 'midpoint', the function needs to implement 
%              the midpoint method.
%              If not supplied, type is set to 'trapezoid'
%   OUTPUT:
%       integral: an array with length(x_values) - 1, values represent the
%       integrated values of each intervals. 
%
%   EXAMPLE: do a numerical integration for function f = @(x) x^2,
%            x_values = x_values = [0.001 : 0.1 : 2], h = 1e-5, type =
%            'trapezoid', and save the result in variable integral
%            
%            integral = integrate(f, x_values, h, type);

function [integral] = integrate(function_handle, x_values, h, type)

% The third argument h should be optional. If not supplied, set to 1e-5.
% The fourth argument type should be optional. If not supplied, set to
% 'trapezoid'.
if nargin < 4
    if ~exist('h', 'var')
        h = 1e-5;
        type = 'trapezoid';
    elseif ~exist('type', 'var')
        type = 'trapezoid';
    end
end


% error handling to guarantee that h is smaller than the average of 
% all differences x_i+1 - x_i; throw an error if conditions are not
% satisfied.
difsum = 0;
for k = 1 : length(x_values) - 1
    difsum = difsum + x_values(k + 1) - x_values(k);
end

% calculate avgdif, the average of all differences x_i+1 - x_i
avgdif = difsum / (length(x_values) - 1);
if (h < avgdif) == false
    error('h is larger than the average of every difference of x_i+1 - x_i');
end

% The fourth argument type is a string (or char array) with 'trapezoid' and
% 'midpoint' as possible values.
% The function should evaluate the integral for each PAIR of SUCCESSIVE
% x-values and so will return length(x_values) - 1 values.
if strcmp(type, 'trapezoid') == 1
    area = zeros(1, length(x_values) - 1);
    % compute the integral for every interval
    for i = 1 : length(x_values) - 1
        area(i) = 0;
        % compute the area of each the trapezoid with height h, and add the
        % area into area(i)
        for j = x_values(i): h : x_values(i + 1)
            area(i) = area(i) + (h ./ 2 .* (function_handle(j + h) + function_handle(j))); 
        end
    end
    % return array with length(x_values) - 1 values
    integral = area;
    
elseif strcmp(type, 'midpoint') == 1
    area = zeros(1, length(x_values) - 1);
    % compute the integral for every interval
    for i = 1 : length(x_values) - 1
        % compute the area of boxes with length h, height function_handle(midpoint)
        % and add the area of the box into area(i)
        for j = x_values(i): h: x_values(i + 1)
            area(i) = area(i) + (h * function_handle((j + h / 2)));
        end
    end
    % return array with length(x_values) - 1 values
    integral = area;
end





