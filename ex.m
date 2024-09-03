% Read two images
image1 = imread('fusededges.png');
image2 = imread('originaledges.jpg');

% Convert images to grayscale if they are RGB
if size(image1, 3) == 3
    image1 = rgb2gray(image1);
end

if size(image2, 3) == 3
    image2 = rgb2gray(image2);
end

% Apply edge detection using the Canny edge detector
edges1 = edge(image1, 'Canny');
edges2 = edge(image2, 'Canny');

% Display the original images and their corresponding edges
subplot(2, 2, 1);
imshow(image1);
title('Image 1');

subplot(2, 2, 2);
imshow(edges1);
title('Edges of Image 1');

subplot(2, 2, 3);
imshow(image2);
title('Image 2');

subplot(2, 2, 4);
imshow(edges2);
title('Edges of Image 2');

% Compare the two edge images (e.g., using pixel-wise subtraction)
edge_difference = edges1 - edges2;

% Display the difference
figure;
imshow(edge_difference);
title('Difference between Edge Images');

% Alternatively, you can use a similarity metric, such as Structural Similarity Index (SSIM)
ssim_value = ssim(edges1, edges2);
fprintf('Structural Similarity Index (SSIM): %.4f\n', ssim_value);
