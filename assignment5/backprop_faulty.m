% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 5 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
%
% this function implements one backpropagation step - TODO: function does
% not work properly (now works properly, done)
%
% INPUTS:
%           data:   array of data - TODO: check that function works with
%           more than one row of data!! (done)
%           labels: matching labels - TODO: check for same size than data
%           W:      weight matrices as cell array (done)
%           lr:     learning rate
% OUTPUT:
%           weights:updated weight matrices as cell array
%           delta:  update amounts for each weight matrix as cell array
%
% TODO - add argument for both normal and DERIVATIVE of activation function
% (done)
function [weights,delta]=backprop_faulty(data,W,labels,lr,f,f_der)
    % check if sizes of data and labels are appropriate
    if size(data, 1) ~= size(labels, 1)
        error('labels and data are not of appropriate sizes');
    end
    
    % add argument for both normal and DERIVATIVE of activation function
    % set default behaviour
    if nargin == 4
        f = 'logistic';
        f_der = 'logistic';
    elseif nargin == 5
        f_der = f;
    end
    
    % store W in W_org to calculate the output delta
    W_org = W;
    
    % ensure that function works with more than one row of data
    for r=1:size(data, 1)

        % do a feed_forward pass to get all outputs - TODO: fix function!
        O=feed_forward_faulty(data(r, :),W,f);
        % now get the output errors for the last layer (derivative of loss
        % function)
        errors{2}=labels(r) - O{2};
        % weight them with the derivative of the activation function of the
        % output
        delta{2}=errors{2} .* activation_der(O{2}, f_der);

        % now to the hidden layer
        % init errors and deltas
        err=zeros(size(W{1},1),1);
        del=zeros(size(W{1},1),1);
        % get the hidden errors - remember that the LAST element is the bias,
        % which we do not need to touch here [all derivatives with respect to
        % constant weights are, of course, 0

        for j=1:size(W{1},1)
            err(j) = 0.0;
            % get all connected downstream neurons and update
            for n=1:size(W{2},1)
                err(j) = err(j)+W{2}(n,j) * delta{2}(n);
            end
            % again, weight the error by the derivative of the current output
            % in the activation function
            del(j)=err(j)*activation_der(O{1}(j), f_der);
        end
        % assign errors and deltas to cell array for weight update step
        errors{1}=err;
        delta{1}=del;

        % weight update with inputs and errors - this now works from the front

        % initialize input for the first layer as data
        inputs = data(r, :);

        % loop through layers
        for i=1:2
            % if we are not in the first layer, change input to output from
            % previous layer
            if i~=1
                inputs = O{i-1};
            end
            % now get all connected neurons
            for n=1:size(O{i},2)
                % and for all inputs we have, change the weights according to
                % the learning rate
                for j=1:length(inputs)
                    W{i}(n,j) = W{i}(n,j)+ lr * delta{i}(n)*inputs(j);
                end
                % this is the update rule for the BIAS (in the LAST element
                % of our matrix)
                W{i}(n,end) = W{i}(n,end)+ lr * delta{i}(n);
            end
        end
    end
    % calculate delta
    delta{1}=W{1} - W_org{1};
    delta{2}=W{2} - W_org{2};
    
    % save the weights in different variable and return
     weights=W;
end
