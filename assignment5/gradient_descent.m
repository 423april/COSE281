% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% gradient_descent(f,g1,g2,xstart,lambda,tolerance,maxiterations) looks for
% the minimum of a funtion f, given its gradient. 
%
%   INPUT:
%       f: function handle to the definition of the function
%       g1,g2: function handles to the definition of the partial 
%              derivatives of the function f
%       xstart: array of starting values for the optimization
%       lambda: update rate in the gradient descent step
%       tolerance: value of the squared norm of the gradient at which
%                  you accept that the minimum is found
%       maxiterations: maximum number of iterations that is allowed to 
%                      take place
%
%   OUTPUT:
%       xoptimal: an array of optimal points
%       foptimal: function value at xoptimal
%       niterations: number of iterations the algorithm made to reach 
%                    criterion
%


function [xoptimal,foptimal,niterations] = gradient_descent(f,g1,g2,...
    xstart,lambda,tolerance,maxiterations)


end
