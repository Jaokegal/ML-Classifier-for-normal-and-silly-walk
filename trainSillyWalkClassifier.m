   % addpath('ExampleData', 'TestData', 'TrainingData');
   % 
   %  trainingDataDir = dir('TrainingData');
   %  trainingFileNames = {trainingDataDir.name};
   %  trainingFileNames = trainingFileNames(3:end);
   % 
   %  testDataDir = dir('TestData');
   %  testFileNames = {testDataDir.name};
   %  testFileNames = testFileNames(3:end);
   % 
   %  [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames);
   % 
   %  % Normalize the data
   %  [XTrain, XTest] = normalizeData(XTrain, XTest);
   % 
   %  model = trainSillyWalkClassifier1(XTrain, YTrain);
   % 
   % 
   %



function model = trainSillyWalkClassifier(XTrain, YTrain)
    [layers, options] = specify_network();
    model = trainNetwork(XTrain, YTrain, layers, options);
    save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model'); % do not change this line
end



