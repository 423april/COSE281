%% Show predictions for the first 25 images
% Run the file after running Assignment6_CNN.m

% visualise predictions
predictions = classify(net, reshape(images(:, :, 1 : 25), [28 28 1 25]));
figure(2)

for i = 1 : 25
    subplot(5, 5, i)
    imshow(images(:, :, i))
    title({strcat("predicted: ", string(predictions(i))), strcat("actual: ", num2str(labels(i)))});
end