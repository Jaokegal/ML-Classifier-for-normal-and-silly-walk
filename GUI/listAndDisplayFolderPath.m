function fileNames = listAndDisplayFolderPath(folderName)
    addpath(folderName);
    folderContents = dir(folderName);
    fileNames = {folderContents.name};
    fileNames = fileNames(3:end); % Exclude '.' and '..'
    folderPath = fullfile(pwd, folderName);
    disp(['Folder path: ', folderPath]);
    disp('Files:');
    for i = 1:length(fileNames)
        disp(fileNames{i});
    end
end