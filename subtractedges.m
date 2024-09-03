% Read the image
originalImage = imread('your_image.jpg'); % Replace 'your_image.jpg' with the actual file name

% Display the original image
figure;
imshow(originalImage);
title('Original Image');

% Apply Gaussian blur
sigma = 2; % Standard deviation of the Gaussian filter
blurredImage = imgaussfilt(originalImage, sigma);

% Display the blurred image
figure;
imshow(blurredImage);
title('Blurred Image');

% You can adjust the value of 'sigma' to control the amount of blurring.
