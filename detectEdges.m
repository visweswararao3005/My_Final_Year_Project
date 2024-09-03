function edges = detectEdges(ModifiedImage)

    % Convert the image to grayscale
    %image_gray = rgb2gray(ModifiedImage);

    % Apply Gaussian blur
    image_blurred = imgaussfilt(ModifiedImage, 1.5);

    % Perform Canny edge detection
    edges = edge(image_blurred, 'Canny');

    % Display the original image and the detected edges
   
end
