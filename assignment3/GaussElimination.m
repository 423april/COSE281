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
%   EXAMPLE: solve a linear eqation Ax = b for x, where A = [1 0; 0 1] and b =
%   [3; 1] and save the result in the varialbe x. 
%
%       x = GaussElimination(A, b);

function [x] = GaussElimination(A, b)

% error handling!
% check if matrix A is square or not
if (size(A,1) ~= size(A,2))
    error('matrix A is not square');
end

% check whether the dimensions of b and A fit
if(size(A,2) ~= size(b,1))
    error('dimentions of b and A do not fit');
end

% make an augmented matrix
C = [A, b];

% forward elimination
for i = 1 : size(C, 1) - 1
     % partial pivoting
     % change the current row with the row that has maximum absolute
     % leading coefficient value
     [~, exIndex] = max(abs(C(i:size(C,1), i)));
     exIndex = exIndex + i - 1;
     Rtemp = C(exIndex, :);
     C(exIndex, :) = C(i, :);
     C(i, :) = Rtemp;
     C
     
     % if leading coefficient is 0, abort with error
     if(C(i,i) == 0)
        error('the leading coefficient is 0');
     end
     
    for j = i + 1 : size(C, 1)
        div = C(j,i) ./ C(i,i);
        for k = i : size(C, 2)
            C(j,k) = C(j,k) - div .* C(i,k);
        end
    end
    C
end

% backward substitution
A = C(1:size(A,1), 1:size(A,1))
b = C(1:size(A,1), size(C,2))

for i = size(A,1) : -1 : 1 % 구하려는 x값의 행
    sum = 0;
    for l = size(A,1) : -1 : i + 1
        sum = sum + A(i,l) .* x(l);
    end
    x(i) = (b(i) - sum) ./ A(i,i);
end
 
end
