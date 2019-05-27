function out = activation_der(x,type)
    if nargin==1
        type='tanh';
    end
    
    switch type
        case 'tanh'
            out = 1-x.^2;
        case 'logistic'
            out = x.*(1-x);
        case 'relu'
            out = double(x > 0);
        case 'perceptron'
            out = zeros(size(x));
        case 'linear'
            out = ones(size(x));
        otherwise
            error(['do not know type ' type])
    end
% tanh and logistic functions are sigmoid functions (they are similar, but in this case logistic is relatively linear)