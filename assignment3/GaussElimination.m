% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 3 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% GaussElimination(A, b) solves a linear system of equations Ax = b for a
% square matrix A using forward elimination, backward substitution, and
% partial pivoting with the max-element as shown during class. 
%   
%   INPUT:
%       A: square matrix
%       b: output vector
%
%   OUTPUT:
%       x: vector that solves the equation Ax = b.
%
%   EXAMPLE: solve a linear eqation Ax = b for x, where A = [1 0; 0 1] and
%   b = [3; 1] and save the result in the variable x.
%
%       x = GaussElimination(A, b);

function x = GaussElimination(A, b)

% error handling!
% check if matrix A is square
if (size(A, 1) ~= size(A, 2))
    error('The matrix A is not square.');
end

% check whether the dimensions of b and A fit
if(size(A, 2) ~= size(b, 1))
    error('The dimensions of b and A do not fit.');
end

% create the augmented matrix
C = [A b];

% forward elimination
for i = 1 : size(C, 1) - 1
    % partial pivoting
    % interchange the current row and the row that has the greatest
    % absolute "leading coefficient" value
    [~, maxValIndex] = max(abs(C(i : size(C, 1), i)));
    interchangeIndex = maxValIndex + i - 1;
    C([i interchangeIndex], :) = C([interchangeIndex i], :);

    % if "leading coefficient" is 0, abort with error
    if(C(i, i) == 0)
        error('A "leading coefficient" is 0.');
    end
    
%    C(i + 1 : size(C, 1), i : size(C, 2)) = C(i + 1 : size (C, 1), i : size(C, 2)) - C(i + 1 : size (C, 1), i) / C(i, i) * C(i, i : size(C, 2));
    for j = i + 1 : size(C, 1)
        multiplier = C(j, i) / C(i, i);
        for k = i : size(C, 2)
            C(j, k) = C(j, k) - multiplier * C(i, k);
        end
    end
end

% backward substitution

% ALTERNATIVE METHOD
%____________________________
% preallocate x to be a zero vector with the same number of variables as A.
% x = zeros(size(A, 2), 1);
% 
% for i = size(C, 1) : -1 : 1
%     x(i) = (C(i, size(C, 2)) - sum(C(i, 1 : size(A, 2)) * x)) / C(i, i);
% end
%___________________________

% % let U be the new coefficients and p the new constant terms
% U = C(1 : size(A, 1), 1 : size(A, 1));
% p = C(1 : size(A, 1), size(C, 2));
% 
% % "read off" the solutions into x
% for i = size(U, 1) : -1 : 1
%     sum = 0;
%     for l = size(U, 1) : -1 : i + 1
%         sum = sum + U(i, l) * x(l);
%     end
%     x(i, 1) = (p(i) - sum) / U(i, i);
% end

% Question
% b) Which part of the code (forward elimination or backward
% substitution) takes longest to run?
%   Forward elimination usually takes longer to run as more operations are
%   typically required than backwards substitution. Let n be the width of a
%   square coefficient matrix (which equals the number of unknowns). In
%   addition to operations such as partial pivoting and the calculation of
%   multiples, forward elimination involves multiplying and subtracting
%   each element of the remaining matrix (i.e. time complexity of O(n^2))
%   for each row in the matrix. This means that forward elimination has a
%   time complexity of O(n^3). Meanwhile, backward substitution involves
%   dvisions and subtractions using values of the unknowns found in
%   previous operations on a single row (complexity of O(n)) for each row,
%   which results in a time complexity of O(n^2). Hence forward elimination
%   typically takes longer to run.

end
