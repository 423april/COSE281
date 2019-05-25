%% derivative of logistic function
function l = logistic_der(z)

l = z.*(1-z);
%logistic(z).*(1-logistic(z));
end