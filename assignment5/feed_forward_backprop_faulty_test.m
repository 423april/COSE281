% let's do a test of the two functions
clear;

% sample data (2D)
data=[0.4 0.37];

% here's a simple network init with weights
% note that the LAST elements of the weight matrix belong to the bias
% weights in each case

% weights input -> hidden
W{1}=[[0.12, 0.34, 0.87];[0.29, -0.18, 0.55]; [-0.72, 0.19, 0.73]];
% weights hidden -> output
W{2}=[0.25, 0.49, 0.39, 0.44];

% try to execute one feed_forward pass
% if this is correct, then we should receive a cell-array with two
% elements, each of which containing the output of the hidden layer in O{1}
% and of the output layer in O{2}
%
% think about the dimensions first: how many dimensions do we get from each
% layer as output??
%
% size(O{1})=?
% size(O{2})=?
%
% to check where things go wrong, please look at the function inside
O = feed_forward_faulty(data,W);


% BACKPROPAGATION
% ok, now you've hopefully fixed the feed_foward function, let's turn to
% backward propagation
%
% so, here's an expected label for our sample
% with this data, we can now perform backpropagation through the network
expected = [0];

% try to execute a backpropagation pass with the data, weights, expected
% label and a large learning rate
%
% if successful, this will return the NEW weights, as well as HOW MUCH the
% weights were updated in two arrays, weights and delta
%
% to check where things go wrong, please look at the function inside
[weights,delta]=backprop_faulty(data,W,expected,.1);
