% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% SI(x,n) calculates the definite integral of the sinc-function over a
% given interval by using an expression obtained by dividing the Taylor
% series of sin(x) by x and integrating the result term-by-term up to a
% given degree.
%   
%   INPUT:
%       x: array representing the lower and upper limits of the integration
%       interval.
%       n: the degree of the Taylor approximation. This is optional; the
%       default value is n = 10.
%
%   OUTPUT:
%       integral: the definite integral obtained.
%
%   EXAMPLE: Perform integration of sin(x) / x over the interval [0.5, 15]. 
%           x = [0.5 15], n = 15
%
%       integral = SI(x, n)

function [integral] = SI(x, n)
    % set n to its default value, 10, if n is not given
    if nargin == 1
        n = 10;
    end
    
    % preallocate antiderivate, an array representing the antiderivative
    % at the lower and upper limits
    antiderivative = zeros(1, 2);
    
    % compute the Taylor polynomial of the integral of sin(x) / x using the
    % Taylor series of the antiderivative of sin(x) / x obtained
    % algebraically.
    for k = 0 : 1 : n
        antiderivative = antiderivative + (-1) .^ k / (factorial(2 * k + 1) * (2 * k + 1)) * x .^ (2 * k + 1);
    end
    
    % compute the actual definite integral
    integral = antiderivative(2) - antiderivative(1);
end
