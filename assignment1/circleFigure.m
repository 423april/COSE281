% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 1 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% This script plots a circle of radius 10 and a right-angle triangle with 
% an angle of 50 degrees.The code also annotates the angle theta and 
% cos & sin theta.


% close all figures, clear the workspace and output window of Matlab.
clear all
close all
clc

% create figure f2 with the Number property set to 2.
f2 = figure(2);

% turn hold on to retain plots so parts can be added incrementally per
% instructions.
hold on

% set the position of f2 as the bottom-left corner and set the width and
% height of the figure to both be 700 pixels.
set(f2, 'Units', 'pixels', 'Position', [0 0 700 700]);

% plot a circle of radius 10 using 2 suitable functions: 
% f(x)_one (firstFunction) , f(x)_two (secondFunction)
% since x^2 + y^2 = 10^2 => y = sqrt(100 - x^2) or y = -sqrt(100 - x^2), 
% f(x)_one (firstFunction) represents the upper half of the circle.
% f(x)_two (secondFunction) represents the lower half of the circle.
% the circle is centered on (0, 0).
% the figure is plotted over the interval -10 <= x <= 10 in steps of 0.01.
x = [-10 : 0.01 : 10];
firstFunction = sqrt(100 - x.^2);
secondFunction = -sqrt(100 - x.^2);
plot(x, firstFunction, 'r', x, secondFunction, 'r');

% plot a line of length 10 in steps of 0.01 from the origin at an angle of
% 50 degrees with the x-axis using variables base and hypot (short for
% hypotenuse), the vectors representing the x-axis and y-axis values of the
% line respectively.
% the base is the scalar projection of the hypotenuse onto the x-axis,
% hence it can be found using 10 * cosd(50).
base = [0 : 0.01 : 10 * cosd(50)];
hypot = tand(50) .* base;
plot(base, hypot, 'b');

% complete the right-angled triangle from this line: 
% plot the base of the right-angled triangle.
plot(base, zeros(size(base)), 'b');

% plot the height of the right-angled triangle.
% declare height, the y-axis values of the points used to represent the
% height of the right-angled triangle.
% the x-axis value for the points used to represent the height of the
% right-angled triangle can be found by taking the magnitude of the scalar
% projection of the hypotenuse onto the base, which is 10 * cosd(50).
height = [0 : 0.01 : 10 * sind(50)];
plot(10 * cosd(50) * ones(size(height)), height, 'b');

% add labels x and y to the x-axis and the y-axis respectively.
xlabel('x');
ylabel('y');

% show \theta as required.
anno_theta = {[10.7/20 9/20 0.1 0.1], 'String', '\theta', 'EdgeColor', 'none'};
annotation('textbox', anno_theta{:});


% show annotations of cos(theta) and sin(theta) as required.
anno_cos = {[13/20 13/20],  [9.7/20 10.2/20], 'String', 'cos \theta', 'LineWidth', 0.3, 'HeadWidth', 5, 'HeadLength', 5};
annotation('textarrow', anno_cos{:});

anno_sin = {[16/20 15.5/20],  [13/20 13/20], 'String', 'sin \theta', 'LineWidth', 0.3, 'HeadWidth', 5, 'HeadLength', 5};
annotation('textarrow', anno_sin{:});

% save figure to a JPG file named circle.jpg.
saveas(f2, 'circle.jpg');