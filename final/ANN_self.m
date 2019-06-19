% COSE281 ENGINEERING MATHEMATICS 2019 FINAL PROJECT
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% ANN_self.m - use an artificial neural network made manually to predict
%              the age of abalone given certain features (to compare some
%              custom-made functions with the built-in ones)

% clear the workspace, close all figures and clear the output window 
% of Matlab.
clear all
close all
clc

% load abalone data
load abalone.mat

%% Data Manipulation
% separate the dependent and independent variables

% construct full data matrix (the first column, sex, is discarded as it is
% a discrete variable)
data = table2array(abalone(:, 2 : 8));

% obtain labels (age = rings + 1.5)
age = table2array(abalone(:, 9)) + 1.5;


%% Artificial Neural Network Training
% approximately 70% of the data are used for training; the rest are used
% for validation
sz_training = floor(0.7 * size(data, 1));

% generate random indices to use for training
rng('shuffle')
random_indices = randperm(size(data, 1));

% segment the data into training and validation sets using random indices
training_data = data(random_indices(1 : sz_training), :);
validation_data = data(random_indices(sz_training + 1 : end), :);

% create corresponding training and validation ages
training_age = age(random_indices(1 : sz_training));
validation_age = age(random_indices(sz_training + 1 : end));

% initialise weights
% the network has 10 nodes in the hidden layer
% the number of hidden layers can be adjusted freely (min. 1)
weights{1} = randn(10, 8);
weights{2} = randn(1, 11);
% one could probably make a simple function to simplify matching of
% dimensions, but...

% training options
epoch = 10000;
batch_size = 100;
learning_rate = 0.1;

% train the network
network = train_network(weights, training_data, training_age, epoch, batch_size, learning_rate);

% calculate RMSE of untrained network
% the value indicates expectedly that a network with untrained random
% weights cannot predict the age of abalone
untrained = predict(weights, validation_data);
rmse_untrained = sqrt(sum((untrained - validation_age) .^ 2) / size(untrained, 1))

% uncomment the command below to use a pre-trained weights sample
% (normally unnecessary as training time is short)

% load network.mat

trained = predict(network, validation_data);

% on average, the RMSE was 3.12 (mean of rmse_testing below)
% adding additional layers did not improve accuracy significantly
rmse = sqrt(sum((trained - validation_age) .^ 2) / size(trained, 1))

%% Mean RMSE Testing Code
% 
% % perform 50 iterations of generating and training networks with certain
% % architectures to check if architectural differences have an impact in
% % predicting the age of abalone
% 
% % commented out to reduce running time
% 
% rmse_testing = zeros(50, 2);
% rng('shuffle')
% 
% % train a more complicated network
% for i = 1 : 50
%     sz_training = floor(0.7 * size(data, 1));
%     random_indices = randperm(size(data, 1));
% 
%     training_data = data(random_indices(1 : sz_training), :);
%     validation_data = data(random_indices(sz_training + 1 : end), :);
%     training_age = age(random_indices(1 : sz_training));
%     validation_age = age(random_indices(sz_training + 1 : end));
%     
%     weights{1} = randn(10, 8);
%     weights{2} = randn(1, 11);
%     epoch = 10000;
%     batch_size = 100;
%     learning_rate = 0.1;
%     trained = predict(network, validation_data);
%     rmse_testing(i, 1) = sqrt(sum((trained - validation_age) .^ 2) / size(trained, 1));
% 
%     network = train_network(weights, training_data, training_age, epoch, batch_size, learning_rate);
%     
%     trained = predict(network, validation_data);
%     rmse_testing(i, 1) = sqrt(sum((trained - validation_age) .^ 2) / size(trained, 1));
% end
% 
% % train an extremely simple "network"
% for i = 1 : 50
%     sz_training = floor(0.7 * size(data, 1));
%     random_indices = randperm(size(data, 1));
% 
%     training_data = data(random_indices(1 : sz_training), :);
%     validation_data = data(random_indices(sz_training + 1 : end), :);
%     training_age = age(random_indices(1 : sz_training));
%     validation_age = age(random_indices(sz_training + 1 : end));
%     
%     weights{1} = randn(1, 8); % similar to linear regression (7 coefficients + bias)
%     weights{2} = randn(1, 2); % as the function expects at least 2 layers
%     epoch = 10000;
%     batch_size = 100;
%     learning_rate = 0.1;
%     
%     network = train_network(weights, training_data, training_age, epoch, batch_size, learning_rate);
%     
%     trained = predict(network, validation_data);
%     rmse_testing(i, 2) = sqrt(sum((trained - validation_age) .^ 2) / size(trained, 1));
% end
% 
% % Check if the network architecture actually makes a difference
% 
% % hypothesis: 1, p_value: 1.2 * 10^-20 (null hypothesis rejected)
% % mean_difference: -0.41 (>10% of RMSEs)
% % 
% % again, the mean RMSEs of the two architectures are different (more
% % noticeably this time) but not exceedingly "significantly"
% mean_difference = mean(rmse_testing(:, 1)) - mean(rmse_testing(:, 2))
% [hypothesis, p_value] = ttest2(rmse_testing(:, 1), rmse_testing(:, 2))


%% Function Definitions

% functions were to defined here to avoid cluttering, since they are not
% used outside of this file

% train_network - train ANN using mini-batch gradient descent and the
%                 logistic function
function trained_network_weights = train_network(weights, data, labels, epochs, batch_size, learning_rate)
    
    % minimal error checking
    if size(data, 2) ~= (size(weights{1}, 2) - 1)
        error("Size of input weights does not match data");
    elseif size(data, 1) ~= size(labels, 1)
        error("Number of labels does no match data");
    end
    
    % generate random indices for the mini-batches
    rng('shuffle')
    for epoch_count = 1 : epochs
        % set up the first layer
        data_indices = randi(size(data, 1), batch_size, 1);
        batch_data = data(data_indices, :);
        output{1} = 1 ./ (1 + exp(-[batch_data ones(batch_size, 1)] * weights{1}'));
        
        % feed forward through all layers
        for layer = 2 : size(weights, 2)
            output{layer} = 1 ./ ( 1 + exp(-[output{layer - 1} ones(size(output{layer - 1}, 1), 1)] * weights{layer}'));
        end
        
        % use the logistic activation function to calculate delta
        delta{layer} = (labels(data_indices) - output{layer}) .* output{layer} .* (1 - output{layer});
        
        % calculate delta for all layers
        for layer = size(weights, 2) - 1 : -1 : 1
            errors = zeros(size(weights{layer}, 1), 1);
            for neuron_index = 1 : size(weights{layer}, 1)
                for upper_index = 1 : size(weights{layer + 1}, 1)
                    errors(neuron_index) = errors(neuron_index) + weights{layer + 1}(upper_index, neuron_index) * delta{layer + 1}(upper_index);
                end
                delta{layer}(neuron_index) = errors(neuron_index) .* output{layer}(neuron_index) .* (1 - output{layer}(neuron_index));
            end
        end
        
        % update weights for the first layer using data input
        layer = 1;
        for neuron_index = 1 : size(weights{layer}, 1)
            for input_index = 1 : size(batch_data, 2)
                weights{layer}(neuron_index, input_index) = weights{layer}(neuron_index, input_index) + learning_rate * delta{layer}(neuron_index) * batch_data(input_index);
            end
            weights{layer}(neuron_index, input_index + 1) = weights{layer}(neuron_index, input_index + 1) + learning_rate * delta{layer}(neuron_index);
        end

        % update weights for subsequent layers using their previous layer
        for layer = 2 : size(weights, 2)
            for neuron_index = 1 : size(weights{layer}, 1)
                for input_index = 1 : size(output{layer - 1}, 2)
                    weights{layer}(neuron_index, input_index) = weights{layer}(neuron_index, input_index) + learning_rate * delta{layer}(neuron_index) * output{layer - 1}(input_index);
                end
                weights{layer}(neuron_index, input_index + 1) = weights{layer}(neuron_index, input_index + 1) + learning_rate * delta{layer}(neuron_index);
            end
        end
    end
    
    % save trained weights into output variable;
    trained_network_weights = weights;
end

% predict - predict using data using given weights to an ANN by feeding the
%           data forward
function [prediction] = predict(weights, data)
    % set up the first layer
    output{1} = 1 ./ (1 + exp(-[data ones(size(data, 1), 1)] * weights{1}'));
    
    % feed forward through all layers
    for layer = 2 : size(weights, 2) % in case there are only 2 layers (including the output layer)
        output{layer} = 1 ./ ( 1 + exp(-[output{layer - 1} ones(size(output{layer - 1}, 1), 1)] * weights{layer}'));
    end
    
    % save the actual prediction into the output variable
    prediction = [output{layer - 1} ones(size(output{layer - 1}, 1), 1)] * weights{layer}';
end