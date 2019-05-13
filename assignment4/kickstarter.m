% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% kickstarter.m fits the given data with polynomials from degree 1 until 7
% using the Vandermonde method and plots the measured data points. 

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all;
clear all;
clc;

% define the number of funded and non-funded projects on Kickstarter as 
% row vectors
funded = [373 3772 10746 16903 19271 22233 22036 18823];
nonfunded = [501 4825 12516 22749 24823 44325 54831 39251];

% creates figure for the non-funded projects
figure('Name', 'Question 1: Non-funded Projects', 'Position', [100 100 600 500]);
grid on; 
xlim([0 10]), ylim([-5000 70000])
hold on

% fit the data with polynomials from degree 1 to 7 using the Vandermonde
% method
for i = 1 : 7
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ nonfunded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    % calculate the errors
    err(i) = norm(A * coeff - nonfunded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d, , Error %f', i, err(i)))
end

% calculate the number of non-funded projects in 2020 with the model of
% polynomial degree 2 
P = [0 : 7]' .^ [0 : 2];
p_coeff = P \ nonfunded';
x = [1 8 8^2] * p_coeff;
nonfunded = [nonfunded, x];

% plot the measured data points 
scatter([0 : 8]', nonfunded','displayname','Data'); 

legend('location', 'northwest');

% creates figure for the funded projects
figure('Name', 'Question 1: Funded Projects', 'Position', [730 100 600 500]);
grid on;
xlim([0 10]), ylim([-5000 70000])
hold on

% fit the data with polynomials from degree 1 to 7 using the Vandermonde
% method
for i = 1 : 7
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ funded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    % calculate the errors
    err(i) = norm(A * coeff - funded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d, Error %f', i, err(i)))
end

% calculate the number of non-funded projects in 2020 with the model of
% polynomial degree 2 
Q = [0 : 7]' .^ [0 : 2];
q_coeff = P \ funded';
y = [1 8 8^2] * q_coeff;
funded = [funded, y];
scatter([0 : 8]', funded','displayname','Data'); 
legend('location', 'northwest');

%   Which of the models do you think fits the data best for each of the 
%   two datasets? Do the degrees differ for the two datasets? 
%   Why would they? Why would they not?
% the model with polynomial degree 2 seems to fit the data best. the fit
% quality is not perfect but it generalises well. 