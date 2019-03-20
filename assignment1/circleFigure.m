% ENGINEERING MATHEMATICS ASSIGNMENT 1 PROBLEM #2
% STUDENT ID: 2015320143, 2016320128, 2018320250
% This script plots a circle of radius 10 and a right-angle triangle with 
% an angle of 50 degrees.The code also annotates the angle theta and 
% cos & sin theta.

% code to clear all workspace, all figures and output window of Matlab
clear all
close all
clc

% create numbered figure variable named f2
f2 = figure(2);

% set f2's position property to bottom-left corner
% set width 700 pixels and height 700 pixels 
set(f2, 'Units', 'pixels', 'Position', [0 0 700 700]);

% plot a circle of radius 10 using 2 suitable functions f(x): y1, y2
% y1 is upper half of circle
% y2 is lower half of circle
% circle is centered on (0, 0)
% x's interval is between -10 & 10
x = [-10 : .01 : 10]; 
y1 = sqrt(100 - x.^2);
y2 = -sqrt(100 - x.^2);

% code to plot the triangle
% t1 = length of the base of triangle
% hypot = hypotenuse of triangle
% base = the base of the triangle
% t2 = range of height of triangle
% height = the height of triangle
t1 = [0 : .01 : 10 * cosd(50)];  
hypot = tand(50)*t1;
base = 0 * t1; 
t2 = [0 : .01 : 10 * sind(50)]; 
height = 10 * cosd(50) * (t2 / t2);

% plot circle in red and triangle in blue
plot(x,y1,'r',x,y2,'r', t1,hypot,'b',t1,base,'b', height * ones(size(t2)),t2,'b'); 


% code to show \theta
% we set text coordinates to (.4, .3) so it looks pretty 
text(.4, .3 ,'\theta');

% code for annotation of cos(theta)
text(3.13, -0.13, '\uparrow');
text(2.76, -0.6, 'cos\theta');

% code for annotation of sin(theta)
text(6.43, 3.46, '\leftarrow');
text(6.93, 3.42, 'sin\theta');

%code to save figure into jpg file circle.jpg
%saves plot image as circle.jpg to current directory 
saveas(f2, 'circle.jpg'); 
