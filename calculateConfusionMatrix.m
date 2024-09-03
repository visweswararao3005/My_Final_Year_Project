 function [TP, TN, FP, FN] = calculateConfusionMatrix(image1, image2)
    % % Confusion matrix calculation

     % Calculate true positives, true negatives, false positives, false negatives
     TP = sum(image1(:) & image2(:));
     TN = sum(~image1(:) & ~image2(:));
     FP = sum(~image1(:) & image2(:));
     FN = sum(image1(:) & ~image2(:));
     %disp(['True Positives: ' num2str(TP)]);
 %disp(['True Negatives: ' num2str(TN)]);
 %disp(['False Positives: ' num2str(FP)]);
 %disp(['False Negatives: ' num2str(FN)]);
% acc = ( TP + TN )/ (TP + FP + TN +FN);
%disp(['Accuracy 2  : ' num2str(acc)]);

end
