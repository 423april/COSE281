%% feed_forward function for a standard one-hidden-layer net
% function adds the bias term internally to the last element!
%
% TODO: fix function!
% TODO: add functionality to pass argument for activation function
function O = feed_forward_faulty(X,W)

% Hidden layer function
tmp = [X ones(size(X,1),1)]*W{1};
O{1} = logistic(tmp); % TODO - replace by function call to activation function

% Output layer function
tmp = [O{1} ones(size(O{1},1),1) ]*W{2};
O{2} = logistic(tmp); % TODO - replace by function call to activation function
end