% Existing Edge detection algorithm based on improved adaptive double threshold Canny operator
function  edges = existing_canny_edge_detection(image)
    

    % Calculate the Otsu threshold for segmentation
    threshold = graythresh(image);

    % Calculate the low and high thresholds based on the Otsu threshold
    low_threshold = threshold * 0.3;
    high_threshold = threshold * 1.0;

    % Apply Canny edge detection
    edges = edge(image, 'Canny', [low_threshold, high_threshold]);

    % Display the results
    %figure();
    %subplot(1, 3, 1), imshow(Original), title('Original Image');
    %subplot(1, 3, 2), imshow(ModifiedImage), title(['Noise ' num2str(noiseValue)]);
    %subplot(1, 3, 3), imshow(edges), title('Canny');

end