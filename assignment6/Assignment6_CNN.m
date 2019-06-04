% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 6
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% Note:
%   Understandably, the original comments below may no longer reflect the
%   actual code. Where drastic changes have been made, comments have been
%   added to explain the new code.
%   
%   The CIFAR-10 dataset was used to complete the task.
%   (Krizhevsky, Alex. 2009. â€œLearning Multiple Layers of Features from
%   Tiny Images.â€?)


%% Create Simple Deep Learning Network for Classification
%% STOLEN FROM MATLAB's OWN DEMO!!!
% This example shows how to create and train a simple convolutional neural
% network for deep learning classification. Convolutional neural networks
% are essential tools for deep learning, and are especially suited for
% image recognition.
%
% The example demonstrates how to: 
% * Load and explore image data.
% * Define the network architecture.
% * Specify training options.
% * Train the network.
% * Predict the labels of new data and calculate the classification
% accuracy.

clear all
close all
clc

%% Load and Explore Image Data
% Load the digit sample data as an image datastore. |imageDatastore|
% automatically labels the images based on folder names and stores the data
% as an |ImageDatastore| object. An image datastore enables you to store
% large image data, including data that does not fit in memory, and
% efficiently read batches of images during training of a convolutional
% neural network.


% images.mat is a small subset of the CIFAR-10 dataset that has been
% grayscaled and resized. The following 5 categories of sample size > 1000
% have been extracted. Label numberings were preserved.
% 
% 0 - Airplanes
% 3 - Cats
% 6 - Frogs
% 7 - Horses
% 8 - Ships

types = [0 3 6 7 8];
type_names = ["Airplane" "Cat" "Frog" "Horse" "Ship"];


% In images.mat: 
%   resized_grayscale_images: 28-by-28-by-5077 array representing CIFAR-10
%   images that have been grayscaled and resized using a separate custom
%   MATLAB script.
% 
%   labels: 5077-by-1 vector that provides the labels for each image in
%   resized_grayscale_images.

load images.mat
images = resized_grayscale_images;

%%
% Display some of the image in the datastore.

figure;
perm = randperm(size(images, 3),20);
for i = 1:20
    subplot(4,5,i);
    imshow(images(:, :, perm(i)));
end

%%
% Calculate the number of images in each category. |labelCount| is a table
% that contains the labels and the number of images having each label. The
% datastore contains 1000 images for each of the digits 0-9, for a total of
% 10000 images. You can specify the number of classes in the last fully
% connected layer of your network as the |OutputSize| argument.
labelCount = array2table(sum(labels == types), 'VariableNames', type_names)

%%
% You must specify the size of the images in the input layer of the
% network. Check the size of the first image in |digitData|. Each image is
% 28-by-28-by-1 pixels.
size(images(:, :, 1))

%% Specify Training and Validation Sets
% Divide the data into training and validation data sets, so that each
% category in the training set contains 750 images, and the validation set
% contains the remaining images from each label. |splitEachLabel| splits
% the datastore |digitData| into two new datastores, |trainDigitData| and
% |valDigitData|.

% approximately 90% of images are used for training; the rest are used for
% validation
trainNumFiles = floor(0.9 * size(images, 3));

% generate random indices to use for training
random_indices = randperm(size(images, 3));

% generate training and validation data using random indices

% since trainNetwork takes a 4-D numeric array (explained in further detail
% below), the data is reshaped to denote the presence of 1 channel.
trainImageData = reshape([images(:, :, random_indices(1 : trainNumFiles))], [28 28 1 trainNumFiles]);
valImageData = reshape([images(:, :, random_indices(trainNumFiles + 1 : end))], [28 28 1 size(images, 3) - trainNumFiles]);

% define categorical labels for later use
trainCategories = categorical(labels(random_indices(1 : trainNumFiles)));
valCategories = categorical(labels(random_indices(trainNumFiles + 1 : end)));

%% Define Network Architecture
% Define the convolutional neural network architecture.
layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(5)
    softmaxLayer
    classificationLayer];

%%
% *Image Input Layer* An
% <docid:nnet_ref.mw_fcd2d9b1-ce25-49d1-9d06-b7cf41594ff4> is where you
% specify the image size, which, in this case, is 28-by-28-by-1. These
% numbers correspond to the height, width, and the channel size. The digit
% data consists of grayscale images, so the channel size (color channel) is
% 1. For a color image, the channel size is 3, corresponding to the RGB
% values. You do not need to shuffle the data because |trainNetwork|, by
% default, shuffles the data at the beginning of training.

%%
% *Convolutional Layer* In the convolutional layer, the first argument is
% |filterSize|, which is the height and width of the filters the training
% function uses while scanning along the images. In this example, the
% number 3 indicates that the filter size is 3-by-3. You can specify
% different sizes for the height and width of the filter. The second
% argument is the number of filters, |numFilters|, which is the number of
% neurons that connect to the same region of the input. This parameter
% determines the number of feature maps. Use the |'Padding'| name-value
% pair to add padding to the input feature map. For a filter size of 3, a
% padding of 1 ensures that
%  the spatial output size
% is the same as the input size. You can also define the |Stride| and
% learning rates for this layer using name-value pair arguments of
% <docid:nnet_ref.mw_2d97b6cd-f8aa-4fad-88d6-d34875484820>.

%%
% *Batch Normalization Layer* Batch normalization layers normalize the
% activations and gradients propagating through a network, making network
% training an easier optimization problem. Use batch normalization layers
% between convolutional layers and nonlinearities, such as ReLU layers, to
% speed up network training and reduce the sensitivity to network
% initialization. Use
% <docid:nnet_ref.mw_b7913af4-3a40-4020-bb2c-18c946f5eadd> to create a
% batch normalization layer.

%%
% *ReLU Layer* The batch normalization layer is followed by a nonlinear
% activation function. The most common activation function is the rectified
% linear unit (ReLU). Use
% <docid:nnet_ref.mw_ca5427bd-5cdc-4a58-ba63-302c257d8222> to create a ReLU
% layer.

%%
% *Max-Pooling Layer* Convolutional layers (with activation functions) are
% sometimes followed by a down-sampling operation that reduces the spatial
% size of the feature map and removes redundant spatial information.
% Down-sampling makes it possible to increase the number of filters in
% deeper convolutional layers without increasing the required amount of
% computation per layer. One way of down-sampling is using a max pooling,
% which you create using
%  <docid:nnet_ref.mw_d2785483-a560-4276-a1c0-daa5f58a1d4b>.
% The max pooling layer returns the maximum values of rectangular regions
% of inputs, specified by the first argument, |poolSize|. In this example,
% the size of the rectangular region is [2,2]. The |'Stride'| name-value
% pair argument specifies the step size that the training function takes as
% it scans along the input.

%%
% *Fully Connected Layer* The convolutional and down-sampling layers are
% followed by one or more fully connected layers. As its name suggests, a
% fully connected layer is a layer in which the neurons connect to all the
% neurons in the preceding layer. This layer combines all the features
% learned by the previous layers across the image to identify the larger
% patterns. The last fully connected layer combines the features to
% classify the images. Therefore, the |OutputSize| parameter in the last
% fully connected layer is equal to the number of classes in the target
% data. In this example, the output size is 10, corresponding to the 10
% classes. Use <docid:nnet_ref.mw_1e7fbc56-4746-4f30-8cd9-7048ce806a0d> to
% create a fully connected layer.

%%
% *Softmax Layer* The softmax activation function normalizes the output of
% the fully connected layer. The output of the softmax layer consists of
% positive numbers that sum to one, which can then be used as
% classification probabilities by the classification layer. Create a
% softmax layer using the
% <docid:nnet_ref.mw_a09d3c68-d062-4692-a950-9a7fea5c40c3> function after
% the last fully connected layer.

%%
% *Classification Layer* The final layer is the classification layer. This
% layer uses the probabilities returned by the softmax activation function
% for each input to assign the input to one of the mutually exclusive
% classes and compute the loss. To create a classification layer, use
% <docid:nnet_ref.bu5lho8>.

%% Specify Training Options
% After defining the network structure, specify the training options. Set
% the maximum number of epochs to 3. An epoch is a full training cycle on
% the entire training data set. Start training with an initial learning
% rate of 0.01. Monitor the network accuracy during training by specifying
% validation data and validation frequency. The software trains the network
% on the training data and calculates the accuracy on the validation data
% at regular intervals during training. The validation data is not used to
% update the network weights. Turn on the training progress plot, and turn
% off the command window output.
options = trainingOptions('sgdm',...
    'MaxEpochs',3, ... % change the nubmer of epochs to 10 to increase accuracy
    'ValidationData',{valImageData valCategories},... % ValidationData has been changed into a custom cell array
    'ValidationFrequency',30,...
    'Verbose',true,...
    'Plots','training-progress','ExecutionEnvironment','cpu');

%% Train Network Using Training Data
% Train the network using the architecture defined by |layers|, the
% training data, and the training options.  By default, |trainNetwork| uses
% a GPU if one is available (requires Parallel Computing Toolbox(TM) and a
% CUDA-enabled GPU with compute capability 3.0 or higher). Otherwise, it
% uses a CPU. You can also specify the execution environment by using the
% |'ExecutionEnvironment'| name-value pair argument of |trainingOptions|.

%%
% The training progress plot shows the mini-batch loss and accuracy and the
% validation loss and accuracy. For more information on the training
% progress plot, see
% <docid:nnet_examples.mw_507458b6-14c3-4a31-884c-9f2119ff7e05>. The loss
% is the <docid:nnet_ref.bu80p30-3 cross-entropy loss>. The accuracy is the
% percentage of images that the network classifies correctly.


% (From MATLAB Documentation)
%       trainedNet = trainNetwork(X,Y,layers,options) trains a network for
%       image classification and regression problems. X contains the
%       predictor variables and Y contains the categorical labels or
%       numeric responses.
net = trainNetwork(trainImageData, trainCategories,layers,options);

%% Classify Validation Images and Compute Accuracy
% Predict the labels of the validation data using the trained network, and
% calculate the final validation accuracy. Accuracy is the fraction of
% labels that the network predicts correctly. In this case, more than 99%
% of the predicted labels match the true labels of the validation set.

% The accuracy of the neural network (usually greater than 60%) is
% significantly lower than 99%, but nevertheless markedly greater than
% chance (20%). Considering the fact that the images have been grayscaled
% and resized and that a very generic CNN architecture was used, we
% concluded that the results were acceptable. Increasing the number of
% epochs up to 10 increases the accuracy (to above 65%). Doubling the size
% of the dataset also increases the accuracy (to approximately 75% when
% combined with an increase in the number of epochs). Increasing the depth
% of the CNN significantly or making minimal changes to the network
% structure did not lead to significant changes in accuracy.
predictedLabels = classify(net,valImageData);
valLabels = valCategories;

accuracy = sum(predictedLabels == valLabels)/numel(valLabels)
