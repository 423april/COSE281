% ENGINEERING MATHEMATICS ASSIGNMENT 1 PROBLEM #1
% STUDENT ID: 2015320143, 2016320128, 2018320250
% This script plots function f(x) = abs(sin(x)/x) in the interval
% -100 <= x <= 100. The script also calculates and prints out the values 
% of limit to 0 and positive & negative infinity for f(x).


% code to clear all workspace, all figures and output window of Matlab
clear all
close all
clc

% create numbered figure variable named f1
f1 = figure(1);

% set position property to bottom-left corner
% set width to 600 pixels and height to 400 pixels 
set(f1, 'Units', 'pixels', 'Position', [0 0 600 400]);

% plot function f(x) = abs(sin(x)/x) in interval -100<=x<=100
% supply x array w enough points to get smooth plotting behaviour
% x has interval steps of 0.01 and has total 20001 points 

x = [-100 : .01 : 100];
y = abs(sin(x) ./ x);
plot(x, y);

% adds x & y (f(x)) labels to the plot
xlabel('x'); 
ylabel('f(x)'); 
 
%code to save figure into png file sinc.png
%saves plot image as sinc.png to current directory 
saveas(f1, 'sinc.png'); 


% Questions
% 1a) Based on the plot, what seems to be the value of f(0)?
% --> The value of f(0) seems to be 1 based on the plot.
% 1b) Why am I asking about this value?
% --> If we substitute x with 0 in the given function
% f(x)=abs(sin(x)/x), it will be f(0) = abs(sin(0)/0), which will be
% undefined because we cannot divide by 0.But we seem to have a value based
% on the graph.
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


