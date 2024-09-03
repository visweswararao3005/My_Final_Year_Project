%Proposed Edge Detection Algorithm
function edges = proposed_sobelEdgeDetection(ModifiedImage)
    
    %ModifiedImage=imread("Y2.jpg");

    % Calculate the Otsu threshold for segmentation
    threshold = graythresh(ModifiedImage);

    % Calculate the Otsu threshold for segmentation
    threshold = threshold * 0.2;
    %threshold = 0.3;
    
    % Define the Sobel kernels
    sobelX = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    sobelY = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

    % Convolve the image with the Sobel kernels
    Gx = conv2(double(ModifiedImage), sobelX, 'same');
    Gy = conv2(double(ModifiedImage), sobelY, 'same');

    % Compute the magnitude of the gradient
    edgeImage = sqrt(Gx.^2 + Gy.^2);

    % Normalize the edge image to the range [0, 255]
    edgeImage1 = uint8(edgeImage / max(edgeImage(:)) * 255);
    % Apply Sobel edge detection
    edges = edge(edgeImage1, 'sobel',threshold);
    
    % Display the results
    %figure();
    %subplot(1, 3, 1), imshow(ModifiedImage), title('Original Image');
    %subplot(1, 3, 2), imshow(ModifiedImage), title(['Noise ' num2str(noiseValue)]);
    %subplot(1, 3, 3), imshow(edges), title('sobel');

%end
