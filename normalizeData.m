function [XTrain, XTest] = normalizeData(XTrain, XTest)
    % Normalize the data to have zero mean and unit variance
    XTrain = cellfun(@(x) (x - mean(x, 1)) ./ std(x, [], 1), XTrain, 'UniformOutput', false);
    XTest = cellfun(@(x) (x - mean(x, 1)) ./ std(x, [], 1), XTest, 'UniformOutput', false);
end
