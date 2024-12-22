function [layers, options] = specify_network()
    inputSize = 3;
    numHiddenUnits = 50;  % Increased number of hidden units
    numClasses = 2;

    layers = [...
        sequenceInputLayer(inputSize)
        %lstmLayer(numHiddenUnits, 'OutputMode', 'last')
        gruLayer(numHiddenUnits, 'OutputMode', 'last')  % Replaced lstmLayer with gruLayer
        dropoutLayer(0.5)  % Added dropout layer to prevent overfitting
        reluLayer
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    maxEpochs = 50 ;  % Increased number of epochs
    miniBatchSize = 16;  % Adjusted batch size

    options = trainingOptions('adam', ...
        'MaxEpochs', maxEpochs, ...
        'MiniBatchSize', miniBatchSize, ...
        'InitialLearnRate', 0.001, ...
        'GradientThreshold', 1, ...
        'ValidationFrequency', 30, ...
        'Verbose', false, ...
        'Plots', 'none');
end
