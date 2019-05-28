% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250

%% feed_forward function for a standard one-hidden-layer net
% function adds the bias term internally to the last element!
%
% TODO: fix function! (done)
% TODO: add functionality to pass argument for activation function (done)
function O = feed_forward_faulty(X,W,f)
if nargin == 2
    f = 'logistic';
end
% Hidden layer function
tmp = [X ones(size(X,1),1)]*W{1}';
O{1} = activation(tmp, f); % TODO - replace by function call to activation function

% Output layer function
tmp = [O{1} ones(size(O{1},1),1) ]*W{2}';
O{2} = activation(tmp, f); % TODO - replace by function call to activation function
end