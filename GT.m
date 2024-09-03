% Read the given image
givenImage = imread('A1.jpg'); % Replace 'given_image.jpg' with the filename of your image

% Create a blank ground truth image with the same size as the given image
groundTruth = rand(size(givenImage, 1), size(givenImage, 2));

% Define the region or object of interest in the given image
% For example, let's say you want to mark a rectangular region as foreground
% You need to define the coordinates of the rectangle
% Here, I'm assuming a rectangular region from (50,50) to (150,150)
foregroundRegion = [50, 50, 100, 100]; % [xmin, ymin, width, height]

% Mark the foreground region in the ground truth image as 1
groundTruth(foregroundRegion(2):foregroundRegion(2)+foregroundRegion(4)-1, ...
    foregroundRegion(1):foregroundRegion(1)+foregroundRegion(3)-1) = 1;

% Display the given image and the ground truth image side by side for visualization
subplot(1, 2, 1);
imshow(givenImage);
title('Given Image');

subplot(1, 2, 2);
imshow(groundTruth);
title('Ground Truth');

% Optionally, you can save the ground truth image
%imwrite(groundTruth, 'ground_truth_image.jpg'); % Save the ground truth image as 'ground_truth_image.png'
