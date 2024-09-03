% Load the original image
originalImage = imread('c1.jpg');

% Create a blank binary mask (initialize with zeros)
groundTruthMask = zeros(size(originalImage, 1), size(originalImage, 2));

% Display the original image
figure;
subplot(1, 2, 1);
imshow(originalImage);
title('Original Image');

% Create a ground truth image by overlaying the mask on the original image
%groundTruthImage = originalImage;
%groundTruthImage(repmat([1, 1, size(originalImage, 3)])) = 255;

% Display the ground truth image
subplot(1, 2, 2);
imshow(groundTruthMask);
title('Ground Truth Image');

