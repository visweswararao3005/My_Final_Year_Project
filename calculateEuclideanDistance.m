function euclideanDistance = calculateEuclideanDistance(image1, image2)
    % Convert images to double for numerical calculations
    image1 = double(image1);
    image2 = double(image2);

    % Ensure both images have the same size
    assert(all(size(image1) == size(image2)), 'Images must have the same dimensions.');

    % Calculate the squared differences
    squaredDifferences = (image1 - image2).^2;

    % Sum of squared differences
    sumSquaredDifferences = sum(squaredDifferences(:));

    % Calculate the Euclidean distance
    euclideanDistance = (sqrt(sumSquaredDifferences)*10^-4);
end
