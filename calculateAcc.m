function [TP,TN,FP,FN] = calculateAcc(image1,image2)
    image1 = im2bw(image1);
    image2 = im2bw(image2); 
% Calculate true positives, true negatives, false positives, false negatives
    TP = sum(image1(:) & image2(:));
    TN = sum(~image1(:) & ~image2(:));
    FP = sum(~image1(:) & image2(:));
    FN = sum(image1(:) & ~image2(:));
end