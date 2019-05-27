% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% gradient_descent(f,g1,g2,xstart,lambda,tolerance,maxiterations) looks for
% the minimum of a function f, given its gradient. It returns an array of
% optimal points, the function value at those points, and the number of
% iterations taken to find the minimum.
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

    % choose starting values for optimisation: x1, x2 
    x1 = xstart(1);
    x2 = xstart(2);
    
    % loop to find minimum with gradient descent
    for  iter = 1 : maxiterations
        % temporary variables t1, t2 to store previous values of x1, x2
        t1 = x1;
        t2 = x2;
        
        % update x1, x2 with gradient descent
        x1 = t1 - lambda * g1(t1,t2);
        x2 = t2 - lambda * g2(t1,t2);
        
        % define variable for the squared norm of the gradient
        L2 = sqrt(g1(t1,t2)^2 + g2(t1,t2)^2);
        
        % when accepted minimum is found, break
        if L2 <= tolerance
            break;
        end
    end
    
    % return values for xoptimal, foptimal and niterations
    xoptimal = [x1 x2];
    foptimal = f(x1, x2);
    niterations = iter;  
    
end
