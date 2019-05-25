function out = activation(x,type)
    if nargin==1
        type='tanh';
    end
    
    switch type
        case 'tanh'
            out = tanh(x);
        case 'logistic'
            out = 1./(1+exp(-x));
        case 'relu'
            out = max(zeros(size(x)),x);
        case 'perceptron'
            out = double(x>=0);
        case 'linear'
            out = x;
        otherwise
            error(['do not know type ' type])
    end
% tanh and logistic functions are sigmoid functions (they are similar, but in this case logistic is relatively linear)