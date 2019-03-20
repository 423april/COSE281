% ENGINEERING MATHEMATICS ASSIGNMENT 1 PROBLEM #2
% STUDENT ID: 2015320143, 2018320250
% This script plots a circle of radius 10 and a right-angle triangle with 
% an angle of 50 degrees.The code also annotates the angle theta and 
% cos & sin theta.

% code to clear all workspace, all figures and output window of Matlab
clear all
close all
clc

% create numbered figure variable named f2
f2 = figure(2);

% set position property to bottom-left corner
% set width 700 pixels and height 700 pixels 
set(f2, 'Units', 'pixels', 'Position', [0 0 700 700]);

% plot a circle of radius 10 using 2 suitable functions f(x): y1, y2
% y1 is upper half of circle
% y2 is lower half of circle
% circle is centered on (0, 0)
% x's interval is between -10 & 10
x = [-10:.01:10]; 
y1 = sqrt(100 - x.^2);
y2 = -sqrt(100 - x.^2);
t1 = [0:.01:10*cosd(50)];  %length of the base of triangle
y3 = tand(50)*t1;  %hypotenuse of triangle
y4 = 0 * t1; %the base of the triangle
y5 = [0:.01:10*sind(50)]; %range of height of triangle
t2 = 10*cosd(50) *(y5/y5); % the height of triangle
plot(x,y1,'r',x,y2,'r', t1,y3,'b',t1,y4,'b', t2*ones(size(y5)),y5,'b'); %plot circle in red and triangle in blue
xlabel('x'); ylabel('f(x)'); % adds x & y (f(x)) labels 



% code to show \theta
anon_theta = {[10.7/20 9/20 0.1 0.1], 'String','\theta', 'EdgeColor', 'none'};
annotation('textbox', anon_theta{:});


% code for annotation of cos(theta) and sin(theta)
anon_cos = {[13/20 13/20],  [9.7/20 10.2/20], 'String', 'cos \theta', 'LineWidth', 0.3, 'HeadWidth', 5, 'HeadLength', 5};
annotation('textarrow', anon_cos{:});

anon_sin = {[16/20 15.5/20],  [13/20 13/20], 'String', 'sin \theta', 'LineWidth', 0.3, 'HeadWidth', 5, 'HeadLength', 5};
annotation('textarrow', anon_sin{:});

%code to save figure into jpg file circle.jpg
%saves plot image as circle.jpg to current directory 
saveas(f2,'circle.jpg'); 
