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

    windowedData = windowedData';
    labels = labels';
  


end
    