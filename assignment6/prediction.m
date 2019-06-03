%% Show predictions for the first 25 images
%
% Run the file after running Assignment6_CNN.m
% Note: not directlya part of the assignment


% visualise predictions

% classify the first 25 images
predictions = classify(net, reshape(images(:, :, 1 : 25), [28 28 1 25]));

% use figure 2 (to preserve figure 1 in Assignment6_CNN.m
figure(2)

for i = 1 : 25
    % create subplot
    subplot(5, 5, i)
    
    % display image
    imshow(images(:, :, i))
    
    %show predicted and actual labels.
    title({strcat("predicted: ", string(predictions(i))), strcat("actual: ", num2str(labels(i)))});
end