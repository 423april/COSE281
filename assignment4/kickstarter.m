% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 4 PROBLEM #1
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% kickstarter.m fits the given data about the number of funded and 
% non-funded projects on Kickstarter from 2009 to 2016 with polynomials 
% from degree 1 until 7 using the Vandermonde method and plots the measured 
% data points.

% clear the workspace, close all figures and clear the output window 
% of Matlab
close all
clear all
clc

% define the number of funded and non-funded projects on Kickstarter from 
% 2009 to 2016 as row vectors
nonfunded = [501 4825 12516 22749 24823 44325 54831 39251];
funded = [373 3772 10746 16903 19271 22233 22036 18823];

% define range of years to plot
years = [2009 2022];


%% Create figure for non-funded projects
% set figure properties
figure('Name', 'Question 1: Non-funded Projects', 'Position', [100 100 600 500])
grid on
xlim(years), ylim([-5000 90000])

% set the x-axis values to corresponding years
xticklabels({years(1) + 1 : 2 : years(2) + 1})
hold on

% preallocate err, the SSE for each degree
err = zeros(7, 1);

% fit the data with polynomials from degree 1 to 7 using the Vandermonde
% method
for i = 1 : 7
    
    % create A, the Vandermonde matrix
    A = [0 : 7]' .^ [0 : i];
    
    % solve for coefficients
    coeff = A \ nonfunded';
    
    % calculate the y-values of the polynomial
    y = [0 : 0.05 : years(2) - years(1)]' .^ [0 : i] * coeff;
    
    % calculate errors to measure fit quality
    err(i) = norm(A * coeff - nonfunded');
    
    % plot the polynomial; make the curve of the quadratic model thicker
    if i == 2
        plot([years(1) : 0.05 : years(2)], y, 'linewidth', 3, 'displayname', sprintf('Degree: %d, Error: %.0f', i, err(i)))
    else
        plot([years(1) : 0.05 : years(2)], y, 'linewidth', 0.5, 'displayname', sprintf('Degree: %d, Error: %.0f', i, err(i)))
    end
end

% plot the measured data points for non-funded projects
scatter([years(1) : length(nonfunded) + years(1) - 1]', [nonfunded]', 'displayname', 'Measured Data');

% predict the number of non-funded projects in 2020 using the model of
% polynomial degree 2 
N = [0 : 7]' .^ [0 : 2];
n_coeff = N \ nonfunded';
n_pred = [1 (2020 - years(1)) (2020 - years(1)) ^ 2] * n_coeff;

%plot prediction for the number of non-funded projects in 2020
scatter(2020, n_pred, 'displayname', 'Prediction');

% set legend position
legend('location', 'northwest');


%% Create figure for funded projects
% set figure properties
figure('Name', 'Question 1: Funded Projects', 'Position', [730 100 600 500])
grid on
xlim(years), ylim([-5000 40000])

% set the x-axis values to corresponding years
xticklabels({years(1) + 1 : 2 : years(2) + 1})
hold on

% fit the data with polynomials from degree 1 to 7 using the Vandermonde
% method
for i = 1 : 7
    
    % create A, the Vandermonde matrix
    A = [0 : 7]' .^ [0 : i];
    
    % solve for coefficients
    coeff = A \ funded';
    
    % calculate the y-values of the polynomial
    y = [0 : 0.05 : years(2) - years(1)]' .^ [0 : i] * coeff;
    
    % calculate errors to measure fit quality
    err(i) = norm(A * coeff - funded');
    
    % plot the polynomial; make the curve of the quadratic model thicker
    if i == 4
        plot([years(1) : 0.05 : years(2)], y, 'linewidth', 3, 'displayname', sprintf('Degree: %d, Error: %.0f', i, err(i)))
    else
        plot([years(1) : 0.05 : years(2)], y, 'linewidth', 0.5, 'displayname', sprintf('Degree: %d, Error: %.0f', i, err(i)))
    end
end

% plot the measured data points for funded projects
scatter([years(1) : length(funded) + years(1) - 1]', [funded]', 'displayname', 'Measured Data');

% predict the number of funded projects in 2020 using the model of
% polynomial degree 4
F = [0 : 7]' .^ [0 : 4];
f_coeff = F \ funded';
f_pred = [(2020 - years(1)) .^ [0 : 4]] * f_coeff;

%plot prediction for the number of funded projects in 2020
scatter(2020, f_pred, 'displayname', 'Prediction');

% set legend position
legend('location', 'northwest');

%% Questions)
%     Which of the models do you think fits the data best for each of the
%     two datasets? Do the degrees differ for the two datasets? Why would
%     they? Why would they not?
%     Using your model as a predictor model, how many projects will be
%     funded and non-funded in 2020?
%
%  Answer)
%     For non-funded projects, the quadratic model seems to "fit" the data
%     best. While the seventh-degree polynomial model has the best fit
%     quality overall, it shows signs of over-fitting, which indicates low
%     generalisability. Polynomial regression models of degrees 3 to 6 
%     show an overly drastic decrease in the number of non-funded projects
%     based on a single drop in the number of non-funded projects in 2016.
%     The model predicts 59335 non-funded projects in 2020.
%     
%     On the other hand, a quartic model appears to "fit" the data the best
%     for funded projects. Polynomial models of other degrees predict
%     either excessive growth or excessive decrease, whereas the quartic
%     model follows the trend closely without extreme fluctuation. The
%     model predicts 16181 funded projects in 2020.
%     
%     More data may be required to make accurate predictions, especially
%     for future years, since predictions for the future in general
%     necessarily require extrapolation beyond the range of data. Hence,
%     the models should not be used to predict the number of funded and
%     non-funded projects far off into the future. This is partially why
%     the quartic model was chosen for the number of funded projects, since
%     the given data does not justify a sudden demise of funded Kickstarter
%     projects past 2020 as predicted by the quadratic model where the rate
%     of decrease increases rapidly beyond the range of the data, in
%     addition to the fact that the quartic model shows less fluctutation
%     and has less errors.
%     
%     The two degrees are different as the two sets of data are not
%     directly related, since the number of non-funded projects can change
%     in a different way from the number of funded projects as the barrier
%     of entry in creating a project is low and non-funded projects need
%     not fulfil the general conditions necessary in creating a funded
%     project. In other words, the means by which non-funded projects and
%     funded projects are produced can be wildly dissimilar. Hence, they
%     need not be the same and the data were used to pick an appropriate
%     model for each of them.