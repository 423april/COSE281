% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% kickstarter.m fits the given data about the number of funded and 
% non-funded projects on Kickstarter from 2009 to 2016 with polynomials 
% from degree 1 until 7 using the Vandermonde method and plots the measured 
% data points. 

% clear the workspace, close all figures and clear the output window 
% of Matlab.
close all;
clear all;
clc;

% define the number of funded and non-funded projects on Kickstarter from 
% 2009 to 2016 as row vectors
funded = [373 3772 10746 16903 19271 22233 22036 18823];
nonfunded = [501 4825 12516 22749 24823 44325 54831 39251];

% creates figure for the non-funded projects
figure('Name', 'Question 1: Non-funded Projects', 'Position', [100 100 600 500]);
grid on; 
xlim([0 10]), ylim([-5000 70000]);
% sets the x index values to corresponding years
xticklabels({'2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019'});
hold on

% fit the data with polynomials from degree 1 to 7 using the Vandermonde
% method
for i = 1 : 7
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ nonfunded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    % calculate the errors  ## not sure if it's needed ? 
    err(i) = norm(A * coeff - nonfunded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d, Error %f', i, err(i)))
    % to use if not need error part
    % plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d', i))
end

% predict the number of non-funded projects in 2020 using the model of
% polynomial degree 2 
N = [0 : 7]' .^ [0 : 2];
n_coeff = N \ nonfunded';
n_predict = [1 8 8^2] * n_coeff;

% add the predicted value to the array of number of non-funded projects
nonfunded = [nonfunded, n_predict];

% plot the measured data points for non-funded projects
scatter([0 : 8]', nonfunded','displayname','Data'); 
% set legend position
legend('location', 'northwest');

% creates figure for the funded projects
figure('Name', 'Question 1: Funded Projects', 'Position', [730 100 600 500]);
grid on;
xlim([0 10]), ylim([-5000 70000]);
% sets the x index values to corresponding years
xticklabels({'2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019'});
hold on

% fit the data with polynomials from degree 1 to 7 using the Vandermonde
% method
for i = 1 : 7
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ funded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    % calculate the errors  ## not sure if it's needed ? 
    err(i) = norm(A * coeff - funded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d, Error %f', i, err(i)))
    % to use if not need error part
    % plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d', i))
end

% predict the number of funded projects in 2020 using the model of
% polynomial degree 2 
F = [0 : 7]' .^ [0 : 2];
f_coeff = F \ funded';
f_predict = [1 8 8^2] * f_coeff;

% add the predicted value to the array of number of funded projects
funded = [funded, f_predict];

% plot the measured data points for non-funded projects
scatter([0 : 8]', funded','displayname','Data'); 
% set legend position
legend('location', 'northwest');

%% Questions)
%   Which of the models do you think fits the data best for each of the 
%   two datasets? Do the degrees differ for the two datasets? 
%   Why would they? Why would they not?
%   Using your model as a predictor model, how many projects will be funded
%   and non-funded in 2020?
% Answer)
% for the data set of non-funded projects, the model with polynomial degree
% of 2 seems to fit the data best. while the model with polynomial degree 7
% fits the data with no errors, it overfits. models with polynomial degrees 
% 4 to 6 are more general than 7, but they seem to be predicting that the 
% number of non-funded projects will decrease dramatically based on the 
% sudden drop from 2015 to 2016. based on the steady increasing trend from 
% 2009 to 2015, the drop in 2016 may be a singular occurence. therefore,
% model with polynomial degree 2 seems to be the best compromise between
% fit quality and generalizability. this model predicts that about 52335
% projects will be funded in 2020.
% for the data set of funded projects, the model with polynomial degree
% of 2 seems to fit the data best. the models with polynomial degrees 6 and
% 7 predict a sudden increase, and the models with polynomial degrees 3 and
% 5 predict a sudden decrease. however, changes in the number of funded
% projects in the past years do not show any sharp peaks or drops, so the
% models' predictions seem unrealistic. the model with polynomial degree 2
% not only generalises well but also reflects the past trend, best fitting
% the data. based on this model, there will be about 17372 funded projects 
% in 2020. 