function edgeImage = sobelEdgeDetection(image)
    % Convert the input image to grayscale if it's not already
    if size(image, 3) == 3
        grayImage = rgb2gray(image);
    else
        grayImage = image;
    end

    % Define the Sobel kernels
    sobelX = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    sobelY = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

    % Convolve the image with the Sobel kernels
    Gx = conv2(double(grayImage), sobelX, 'same');
    Gy = conv2(double(grayImage), sobelY, 'same');

    % Compute the magnitude of the gradient
    edgeImage = sqrt(Gx.^2 + Gy.^2);

    % Normalize the edge image to the range [0, 255]
    edgeImage = uint8(edgeImage / max(edgeImage(:)) * 255);
end

% Example usage: 
% Load an image
% inputImage = imread('your_image_path.jpg');
% Apply Sobel edge detection
% edgeImage = sobelEdgeDetection(inputImage);
% Display the edge-detected image
% imshow(edgeImage);
