function GUI
    % app structure
    global app;
    % Create the main UI figure
    app.UIFigure = uifigure('Name', 'Silly Walk Classifier', 'Position', [100, 100, 700, 800]);

    % Create tab group
    app.TabGroup = uitabgroup(app.UIFigure, 'Position', [0, 0, 700, 800]);

    %% Create Tab1
    app.TabDataProcessing = uitab(app.TabGroup, 'Title', 'Data Load');

    % Insert the image
    app.ImageSillyWalk = uiimage(app.TabDataProcessing, 'Position', [(700-750)/2, 600, 750, 100],...
        'ImageSource', 'Silly walk.png');

    % Insert title
    labelWidth = 575; 
    labelHeight = 50; 
    app.LabelTitle = uilabel(app.TabDataProcessing, 'Position', [180, 700, labelWidth, labelHeight],...
        'Text', 'Silly Walk Classifier - Data Load', 'FontSize', 25); 

    % Add button to select training data folder
    app.SelectTrainingDataButton = uibutton(app.TabDataProcessing, 'push',...
        'Position', [100, 550, 225, 30], 'Text', 'Select Training Data Folder',...
        'ButtonPushedFcn', @(btn,event) selectTrainingDataFolderCallback(app));

    % TextArea for displaying training data folder path
    app.TrainingDataPath = uitextarea(app.TabDataProcessing,...
        'Position', [100, 500, 225, 40]);

    % ListBox for displaying training data files
    app.TrainingFileList = uilistbox(app.TabDataProcessing,...
        'Position', [100, 380, 225, 100]);

    % Add button to select test data folder
    app.SelectTestDataButton = uibutton(app.TabDataProcessing, 'push',...
        'Position', [375, 550, 225, 30], 'Text', 'Select Test Data Folder',...
        'ButtonPushedFcn', @(btn,event) selectTestDataFolderCallback(app));

    % TextArea for displaying test data folder path
    app.TestDataPath = uitextarea(app.TabDataProcessing,...
        'Position', [375, 500, 225, 40]);

    % ListBox for displaying test data files
    app.TestFileList = uilistbox(app.TabDataProcessing,...
        'Position', [375, 380, 225, 100]);

    % set frequenz
    app.targetSamplingRateHz = uilabel(app.TabDataProcessing, ...
        'Position', [100, 300, 150, 40], 'Text', ' Sampling rate (Hz):','FontSize', 15);
    app.EdittargetSamplingRateHz = uieditfield(app.TabDataProcessing, 'numeric', ...
        'Position', [270, 300, 150, 40], 'Value', 50);
    % set window length
    app.windowLengthSeconds = uilabel(app.TabDataProcessing, ...
        'Position', [100, 250, 150, 40], 'Text', 'Window length (s):','FontSize', 15);
    app.EditwindowLengthSeconds = uieditfield(app.TabDataProcessing, 'numeric', ...
        'Position', [270, 250, 150, 40], 'Value', 3.4);

   
    % data load button
    app.loadDataButton = uibutton(app.TabDataProcessing, 'push', ...
    'Position', [100, 180, 200, 50], 'Text', 'Data Load', 'FontSize', 15, ...
    'ButtonPushedFcn', @(btn,event) loadDataCallback(app));

     %Add a Text Area for displaying data loading status
    app.DataStatusTextArea = uitextarea(app.TabDataProcessing, ...
    'Position', [320, 115, 350, 100],'Editable', 'off');

     % data normalize button
    app.normalizeDataButton = uibutton(app.TabDataProcessing, 'push', ...
    'Position', [100, 100, 200, 50], 'Text', 'Data Normalize', 'FontSize', 15, ...
    'ButtonPushedFcn', @(btn, event) normalizeDataCallback(app));
    %% Create Tab2: Training and Classification
    
    app.TabTrainingClassification = uitab(app.TabGroup, 'Title', 'Training and Classification');
    % Insert the image
    app.ImageSillyWalk = uiimage(app.TabTrainingClassification, 'Position', [(700-750)/2, 600, 750, 100],...
        'ImageSource', 'Silly walk.png');

    % Insert title
    labelWidth = 575; 
    labelHeight = 50; 
    app.LabelTitle = uilabel(app.TabTrainingClassification, 'Position', [95, 700, labelWidth, labelHeight],...
        'Text', 'Silly Walk Classifier - Training and Classification', 'FontSize', 24); 

    % set epochs
    app.LabelEpochs = uilabel(app.TabTrainingClassification, ...
        'Position', [100, 500, 150, 40], 'Text', 'Epochs:','FontSize', 15);
    app.EditFieldEpochs = uieditfield(app.TabTrainingClassification, 'numeric', ...
        'Position', [200, 500, 150, 40], 'Value', 50,'FontSize', 15);
    % set batch size
    app.LabelBatchSize = uilabel(app.TabTrainingClassification, ...
        'Position', [100, 450, 150, 40], 'Text', 'Batch Size:','FontSize', 15);
    app.EditFieldBatchSize = uieditfield(app.TabTrainingClassification, 'numeric', ...
        'Position', [200, 450, 150, 40], 'Value', 16,'FontSize', 15);

    % Button to train the model
    
    app.ButtonTrainModel = uibutton(app.TabTrainingClassification, 'push', ...
    'Text', 'Training and Classification', 'Position', [400, 450, 200, 60], 'FontSize', 13, ...
    'ButtonPushedFcn', @(btn, event) trainAndClassifyCallback(app));

    % Label for Accuracy Result Display
    app.LabelAccuracyResult = uilabel(app.TabTrainingClassification, ...
    'Position', [100, 400, 200, 30], 'Text', 'Result will display here:', 'FontSize', 15);

    % TextArea for displaying Accuracy
    app.TextAreaAccuracy = uitextarea(app.TabTrainingClassification, ...
    'Position', [100, 350, 200, 40], 'Editable', 'off');

    % Gauge for displaying Accuracy
    app.GaugeAccuracy = uigauge(app.TabTrainingClassification,...
        'Position', [330, 280, 160, 160],...
        'ScaleColors',{'red','green'},...
        'ScaleColorLimits', [0 80; 80 100]);


    % Label for Model Details
    app.LabelModelDetails = uilabel(app.TabTrainingClassification, ...
    'Position', [100, 250, 200, 30], 'Text', 'Trained model will display here:', 'FontSize', 15);

    % TextArea for displaying Model Details
    app.TextAreaModelDetails = uitextarea(app.TabTrainingClassification, ...
    'Position', [100, 100, 500, 140], 'Editable', 'off');

    
    
end

%% Callback functions

% Button to select training data
function selectTrainingDataFolderCallback(app)
    global app;
    folderName = 'TrainingData';
    app.TrainingFileNames = listAndDisplayFolderPath(folderName);  % Store filenames
    app.TrainingDataPath.Value = fullfile(pwd, folderName);
    app.TrainingFileList.Items = app.TrainingFileNames;
    drawnow
end

% Button to select test data
function selectTestDataFolderCallback(app)
    global app;
    folderName = 'TestData';
    app.TestFileNames = listAndDisplayFolderPath(folderName);  % Store filenames
    app.TestDataPath.Value = fullfile(pwd, folderName);
    app.TestFileList.Items = app.TestFileNames;
    drawnow
end

% Callback function for loading data
function loadDataCallback(app)
    global app;
    
    targetSamplingRateHz = app.EdittargetSamplingRateHz.Value;
    windowLengthSeconds = app.EditwindowLengthSeconds.Value;

    trainingFileNames = listAndDisplayFolderPath('TrainingData');
    testFileNames = listAndDisplayFolderPath('TestData');

    
    [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames, targetSamplingRateHz, windowLengthSeconds);

    % Display updated info in the Text Area
    dataStatusText = sprintf('Sampling Rate: %d Hz\nWindow Length: %.1f seconds\nTraining Data Loaded: %d samples\nTest Data Loaded: %d samples', ...
                              targetSamplingRateHz, windowLengthSeconds, numel(XTrain), numel(XTest));
    app.DataStatusTextArea.Value = dataStatusText;

    % Display sizes of loaded arrays in Command Window (optional)
    disp(['Training Data Loaded: ', num2str(numel(XTrain)), ' samples']);
    disp(['Test Data Loaded: ', num2str(numel(XTest)), ' samples']);
end

% callbck for normalize data

function normalizeDataCallback(app)
    global app;
    targetSamplingRateHz = app.EdittargetSamplingRateHz.Value;
    windowLengthSeconds = app.EditwindowLengthSeconds.Value;
    trainingFileNames = listAndDisplayFolderPath('TrainingData');
    testFileNames = listAndDisplayFolderPath('TestData');


    [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames, targetSamplingRateHz, windowLengthSeconds);
    [XTrain, XTest] = normalizeData(XTrain, XTest);  % Assuming normalizeData function is defined and works appropriately

    % Store the loaded and normalized data 
    XTrain = XTrain;
    YTrain = YTrain;
    XTest = XTest;
    YTest = YTest;

    % Update the text area to show the data has been loaded and normalized
    dataStatusText = sprintf('Data normalized.\nSampling Rate: %d Hz\nWindow Length: %.1f seconds\nTraining Data Loaded: %d samples\nTest Data Loaded: %d samples', ...
                             targetSamplingRateHz, windowLengthSeconds, numel(XTrain), numel(XTest));
    app.DataStatusTextArea.Value = dataStatusText;
end

% callback train and classification
function trainAndClassifyCallback(app)
        global app;
  
        targetSamplingRateHz = app.EdittargetSamplingRateHz.Value;
        windowLengthSeconds = app.EditwindowLengthSeconds.Value;
        maxEpochs = app.EditFieldEpochs.Value;
        miniBatchSize = app.EditFieldBatchSize.Value;

        trainingFileNames = listAndDisplayFolderPath('TrainingData');
        testFileNames = listAndDisplayFolderPath('TestData');


        [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames, targetSamplingRateHz, windowLengthSeconds);
        [XTrain, XTest] = normalizeData(XTrain, XTest);

        model = trainSillyWalkClassifier(XTrain, YTrain, maxEpochs, miniBatchSize);

        YPred = classifyWalk(model, XTest);
        accuracy = sum(YPred == YTest) / numel(YTest) * 100;
        app.TextAreaAccuracy.Value = sprintf('Accuracy: %.2f%%', accuracy);
        app.GaugeAccuracy.Value = accuracy;
        modelDetails = evalc('disp(model.Layers)');
        app.TextAreaModelDetails.Value = modelDetails;

        disp(['Accuracy: ', num2str(accuracy), '%']);
        disp(model.Layers);
  
end






%% Helper functions
% Add path and list folder contents
function fileNames = listAndDisplayFolderPath(folderName)
    addpath(folderName);
    folderContents = dir(folderName);
    fileNames = {folderContents.name};
    fileNames = fileNames(3:end);
    fileNames = fileNames(~startsWith(fileNames, '._'));%% 
    folderPath = fullfile(pwd, folderName);
    disp(['Folder path: ', folderPath]);
    disp('Files:');
    for i = 1:length(fileNames)
        disp(fileNames{i});
    end
end
%extract data
function [windowedData, labels] = extractData(matFileContent, matFileName, targetSamplingRateHZ, windowLengthSeconds)

    % Resample data to targetSamplingRateHZ using interp1 
    time = matFileContent.time;
    data = matFileContent.data;
    samplingTime = 0:(1/targetSamplingRateHZ):time(end);
    resampledData = transpose(interp1(time,data',samplingTime));

    %Windowing parameters
    windowLength = windowLengthSeconds * targetSamplingRateHZ;
    windowLength = floor(windowLength) - mod(floor(windowLength),2); % round to nearest even number
    windowShift = windowLength / 2;

    % Initialize cell array for storing windows
    windowedData = cell(1);
    labels = cell(1);

    % Create windows
    numWindows = floor((length(resampledData) - windowLength) / windowShift) + 1;
    for k = 1:numWindows
            % Calculate indices for current window
            startIdx = 1 + (k-1) * windowShift;
            endIdx = startIdx + windowLength - 1;

            % Ensure the window does not exceed data length
            if endIdx > length(resampledData)
                break;
            end

            % Extract windowed data
            windowedSegment = resampledData(:,startIdx:endIdx);
            
            % Store windowed segment in cell array X
            windowedData{k} = windowedSegment;
            % Determine label form matFileName
            if endsWith(matFileName,'_N.mat')
                labels{k} = 'Normal walk';
            elseif endsWith(matFileName,'_S.mat')
                labels{k} = 'Silly walk';
            else
                error("unsupported filename format. File name must end with _N.mat or _S.mat ")
            end

            % convert labels to categorical array

    end
    labels = categorical(labels);
    % transpose windowedData and labels
    windowedData = windowedData';
    labels = labels';
  


end
% data load
function [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames, targetSamplingRateHz, windowLengthSeconds)
    XTrain = {};
    YTrain = {};
    XTest = {};
    YTest = {};

    for ind = 1:length(trainingFileNames)
        matFileName = fullfile('TrainingData', trainingFileNames{ind});
        if exist(matFileName, 'file')
            matFileContent = load(matFileName);
            [X, Y] = extractData(matFileContent, matFileName, targetSamplingRateHz, windowLengthSeconds);
            XTrain = [XTrain; X];
            YTrain = [YTrain; Y];
        end
    end

    for ind = 1:length(testFileNames)
        matFileName = fullfile('TestData', testFileNames{ind});
        if exist(matFileName, 'file')
            matFileContent = load(matFileName);
            [X, Y] = extractData(matFileContent, matFileName, targetSamplingRateHz, windowLengthSeconds);
            XTest = [XTest; X];
            YTest = [YTest; Y];
        end
    end
end
% normalize data
function [XTrain, XTest] = normalizeData(XTrain, XTest)
    % Normalize the data to have zero mean and unit variance
    XTrain = cellfun(@(x) (x - mean(x, 1)) ./ std(x, [], 1), XTrain, 'UniformOutput', false);
    XTest = cellfun(@(x) (x - mean(x, 1)) ./ std(x, [], 1), XTest, 'UniformOutput', false);
end

% train
function model = trainSillyWalkClassifier(XTrain, YTrain, maxEpochs, miniBatchSize)
    [layers, options] = specify_network(maxEpochs, miniBatchSize);
    model = trainNetwork(XTrain, YTrain, layers, options);
    save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model');
end
% specify network
function [layers, options] = specify_network(maxEpochs, miniBatchSize)
    
    inputSize = 3;  
    numHiddenUnits = 50;  
    numClasses = 2;  

    
    layers = [
        sequenceInputLayer(inputSize)
        %lstmLayer(numHiddenUnits, 'OutputMode', 'last')
        gruLayer(numHiddenUnits, 'OutputMode','last')
        dropoutLayer(0.5)  
        reluLayer
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer
    ];

   
    options = trainingOptions('adam', ...
        'MaxEpochs', maxEpochs, ...
        'MiniBatchSize', miniBatchSize, ...
        'InitialLearnRate', 0.001, ...
        'GradientThreshold', 1, ...
        'ValidationFrequency', 30, ...
        'Verbose', false, ...
        'Plots', 'none');
end
% classify
function YPred = classifyWalk(model, XTest)
    YPred = classify(model, XTest);
end
