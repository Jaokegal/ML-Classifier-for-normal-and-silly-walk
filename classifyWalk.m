%   addpath('ExampleData', 'TestData', 'TrainingData');
% 
%     trainingDataDir = dir('TrainingData');
%     trainingFileNames = {trainingDataDir.name};
%     trainingFileNames = trainingFileNames(3:end);
% 
%     testDataDir = dir('TestData');
%     testFileNames = {testDataDir.name};
%     testFileNames = testFileNames(3:end);
% 
%     [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames);
% 
%     % Normalize the data
%     [XTrain, XTest] = normalizeData(XTrain, XTest);
% 
%     model = trainSillyWalkClassifier(XTrain, YTrain);
% 
%     YPred = classifyWalk1(model, XTest)
%     accuracy = sum(YPred == YTest)/numel(YTest)*100;
%     disp(['Accuracy: ', num2str(accuracy), '%']);
%


function YPred = classifyWalk(model, XTest)
    YPred = classify(model, XTest);
end



