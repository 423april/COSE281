function out = activation_der(x,type)
    if nargin==1
        type='tanh';
    end
    
    switch type
        case 'tanh'
            out = sech(x).^2;
        case 'logistic'
            out = x.*(1-x);%exp(x)./((1+exp(x)).^2);
        case 'relu'
            out = max(zeros(size(x)),x);
        case 'perceptron'
            out = zeros(size(x));
        case 'linear'
            out = 1;
        otherwise
            error(['do not know type ' type])
    end
% tanh and logistic functions are sigmoid functions (they are similar, but in this case logistic is relatively linear)