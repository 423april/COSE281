% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 2 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% SI(x,n) implements Taylor series to compute sin(x) and devide it by x,
% in order to calculate the integral of the sinc-function.
%   
%   INPUT:
%       x: array of x values
%       n: teh degree of the Taylor approximation. This is optional, the
%       default value is n = 10.
%
%   OUTPUT:
%       integral = an array of definite integral of the sinc-function for
%       x_values
%
%   EXAMPLE: do a definite integral for the sinc-function. 
%           x = [0.5: 0.01: 15], n = 15
%
%       integral = SI(x, n)

function [integral] = SI(x, n)
    if(nargin == 1)
        n = 10;
    end
    
    a = 0;
    b = 0;
    k = 0;
    
    while (k < n)
        a = a + (-1) .^ k / (factorial(2 * k + 1) * (2 * k + 1)) * x(1) .^ (2 * k + 1);
        b = b + (-1) .^ k / (factorial(2 * k + 1) * (2 * k + 1)) * x(2) .^ (2 * k + 1);
        k = k + 1;
    end
    
    integral = b - a;
end
