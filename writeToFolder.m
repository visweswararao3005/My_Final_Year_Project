function writeToFolder(MainFolder, OriginalImage, edgeImage, ImageName, edgeImageName)
    % Check if the folder exists, if not create it
    if ~exist(MainFolder, 'dir')
        mkdir(MainFolder);
    end

    % Construct full file paths
    ImagePath = fullfile(MainFolder, ImageName);
    edgeImagePath = fullfile(MainFolder, edgeImageName);

    % Write images to the specified paths
    imwrite(OriginalImage, ImagePath);
    imwrite(edgeImage, edgeImagePath);
end