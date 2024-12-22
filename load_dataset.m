function [XTrain, YTrain, XTest, YTest] = load_dataset(trainingFileNames, testFileNames)
    targetSamplingRateHz = 50;    
    windowLengthSeconds = 3.4;

    XTrain = {};
    YTrain = {};
    for ind = 1:length(trainingFileNames)
       matFileName = trainingFileNames{ind};
       matFileContent = load(matFileName);
       [X, Y] = extractData(matFileContent, matFileName, targetSamplingRateHz, windowLengthSeconds);
       XTrain = [XTrain; X];
       YTrain = [YTrain; Y];
    end

    XTest = {};
    YTest = {};
    for ind = 1:length(testFileNames)
       matFileName = testFileNames{ind};
       matFileContent = load(matFileName);
       [X, Y] = extractData(matFileContent, matFileName, targetSamplingRateHz, windowLengthSeconds);
       XTest = [XTest; X];
       YTest = [YTest; Y];
    end
end 