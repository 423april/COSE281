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
% undefined since we divide by 0. But we seem to have a value based on the
% graph.
%
% 2) Based on the plot, what seems to be the value of
% lim(x-->+-infinity)f(x)?
% --> Based on the plot, the values of both f(x) to the limit of positive &
% negative inifinity seem to be 0.


% define symbolic variable t
syms t

% define f(x) symbolically by variable s
s = abs(sin(t)/t);

% check limits for 3 cases in 1a & 2
% save the values in a1, a2, a3 in that order
a1 = limit(s, t, 0);
a2 = limit(s, t, Inf);
a3 = limit(s, t, -Inf);

% print with fprintf & nice explanation text 
fprintf('The value of limit(x to 0) (abs(sin(x)/x)) is %d\n', a1);
fprintf('The value of limit(x to positive infinity) (abs(sin(x)/x)) is %d\n', a2);
fprintf('The value of limit(x to negative infinity) (abs(sin(x)/x)) is %d\n', a3);


