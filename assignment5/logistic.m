%% this is the logistic function
function l = logistic(Z)
l = 1./(1 + exp(-Z));
end