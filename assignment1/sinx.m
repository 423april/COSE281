% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 1 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% This script plots the function f(x) = abs(sin(x) ./ x) over the interval
% -100 <= x <= 100. The script also calculates and prints out the limit as
% the function approaches 0, positive infinity and negative infinity.


% close all figures, clear the workspace and output
% window of Matlab.
clear all
close all
clc

% create figure f1 with the Number property set to 1.
f1 = figure(1);

% set the position of f1 as the bottom-left corner and set the width and
% height of the figure to be 600 pixels and 400 pixels respectively.
set(f1, 'Units', 'pixels', 'Position', [0 0 600 400]);

% plot the function f(x) = abs(sin(x) ./ x) over the interval -100 <= x <=
% 100 and supply array x with enough points to get a smooth plotting
% behaviour.
% x is a regularly-spaced vector using 0.01 as the increment between
% elements for a total of 20001 points.
% y is a vector that holds the corresponding y-axis values for y = f(x).
x = [-100 : .01 : 100];
y = abs(sin(x) ./ x);
plot(x, y);

% add axis labels 'x' and 'f(x)' to the x and y axes respectively.
xlabel('x');
ylabel('f(x)');
 
% save figure to a PNG file named sinc.png
saveas(f1, 'sinc.png');


% Questions
% 1a) Based on the plot, what seems to be the value of f(0)?
% Ans: The value of f(0) seems to be 1 based on the plot.
% 
% 1b) Why am I asking about this value?
% Ans: If we substitute x with 0 in the given function, 
% f(x) = abs(sin(x) / x), we see that f(0) = abs(sin(0) / 0), which is
% undefined since we perform division by 0. But we seem to have a value
% based on the graph.
% 
% 2) Based on the plot, what seem to be the limits of f(x) as x approaches
% positve and negative infinity?
% Ans: Based on the plot, the limits of f(x) as x approaches postive and
% negative infinity both seem to be 0.


% define symbolic variable t.
syms t

% define s symbolically as f(t), a function of t.
s = abs(sin(t) / t);

% check the limits for the 3 cases mentioned in 1a) and 2).
% save the values into lim_zero, lim_pos_inf amd lim_neg_inf respectively.
lim_zero = limit(s, t, 0);
lim_pos_inf = limit(s, t, Inf);
lim_neg_inf = limit(s, t, -Inf);

% print results with nice explanation text to command window with fprintf.
fprintf('The limit of f(x) = abs(sin(x) / x) as x approaches 0 is %d\n', lim_zero);
fprintf('The limit of f(x) = abs(sin(x) / x) as x approaches positive infinity is %d\n', lim_pos_inf);
fprintf('The limit of f(x) = abs(sin(x) / x) as x approaches negative infinity is %d\n', lim_neg_inf);


