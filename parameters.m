function [] = parameters( edgeImage , OriginalImage , GroundTruthImage , name , excelFileName , MainFolder )

varNames = {'Name','MSE', 'RMSE', 'ENTROPY', 'TRUE POSITIVE','FALSE POSITIVE','TRUE NEGATIVE','FALSE NEGATIVE','ACCURACY', 'PRECISION','RECALL', 'F MEASURE', 'PSNR', 'EUCLIDEAN DISTANCE', 'EDGE STRENGTH'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       Parameters      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  MSE                  %%%%  
%%%%  RMSE                 %%%%
%%%%  Entropy              %%%%
%%%%  Accuracy             %%%%
%%%%  Precision            %%%%
%%%%  Recall               %%%%
%%%%  F- Measure           %%%%
%%%%  PSNR                 %%%%
%%%%  Euclidean distance   %%%%
%%%%  Edge Strength        %%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%MSE
%MSE = MeanSquareError(edgeImage, GroundTruthImage);
%fprintf("\nmean square error:%f\n",MSE);
%MSE2 = EvaluateParams(edgeImage, GroundTruthImage);

 assert(all(size(edgeImage) == size(GroundTruthImage)), 'Images must be of the same size.');
% 
%     % Convert images to double to avoid integer arithmetic issues
     originalImage = double(edgeImage);
     noisyImage = double(GroundTruthImage);
% 
%     % Calculate mean squared error (MSE)
     MSE = mean((originalImage(:) - noisyImage(:)).^2);
     MSE1 = MSE/1000;
% 
%    
%     fprintf('MSE: %.2f dB\n', mseValue);
% 

%RMSE calculation
 RMSE = sqrt(MSE1);
 disp(['RMSE: ' ,num2str(RMSE)]);

%Entropy
ent_imf=entropy(uint8(edgeImage));
%fprintf('Image entropy:%f\n',ent_imf);

%Accuracy calculation
assert(all(size(edgeImage) == size(GroundTruthImage)), 'Images must be of the same size.');

    % Convert images to double to avoid integer arithmetic issues
    originalImage = double(edgeImage);
    processedImage = double(GroundTruthImage);

    % Count matching pixels
    matchingPixels = sum(originalImage(:) == processedImage(:));

    % Calculate accuracy as the percentage of matching pixels
    totalPixels = numel(originalImage);
    accuracy = (matchingPixels / totalPixels) * 100;
    fprintf('Accuracy: %.2f%%\n', accuracy);

% Confusion matrix calculation
% Convert images to binary if not already
    image1 = im2bw(edgeImage);
   image2 = im2bw(GroundTruthImage);

    % Calculate true positives, true negatives, false positives, false negatives
    truePositives = sum(image1(:) & image2(:));
    trueNegatives = sum(~image1(:) & ~image2(:));
    falsePositives = sum(~image1(:) & image2(:));
    falseNegatives = sum(image1(:) & ~image2(:));
    disp(['True Positives: ' num2str(truePositives)]);
disp(['True Negatives: ' num2str(trueNegatives)]);
disp(['False Positives: ' num2str(falsePositives)]);
disp(['False Negatives: ' num2str(falseNegatives)]);

 confMatrix = confusionmat(image1(:),image2(:));
     disp('Confusion Matrix:');
     disp(confMatrix);


%accuracy
acc = ( truePositives + trueNegatives )/ (truePositives + falsePositives + trueNegatives +falseNegatives);
disp(['Accuracy 2  : ' num2str(acc)]);

% Calculate precision
precision = truePositives / (truePositives + falsePositives);
disp(['Precision: ' num2str(precision)]);

% calculate Recall
recall = truePositives / (truePositives + falseNegatives);
disp(['Recall: ' num2str(recall)]);

% calculate FPR
%fpr = falsePositives / (falsePositives + trueNegatives);
%disp(['FPR: ' num2str(fpr)]);


% f1 score calculation
F1 = 2 * (precision * recall) / (precision + recall);
disp(['F1 Score: ' num2str(F1)]);

%PSNR calculation
 if size(edgeImage,3)~=1     
   org=rgb2ycbcr(edgeImage);  
   test=rgb2ycbcr(GroundTruthImage);  
   Y1=org(:,:,1);  
   Y2=test(:,:,1);  
   Y1=double(Y1);   
   Y2=double(Y2);  
 else            
     Y1=double(edgeImage);  
     Y2=double(GroundTruthImage);  
 end  
   
% if nargin < 2      
%    D = Y1;  
% else  
%   if any(size(Y1)~=size(Y2))  
%     error('The input size is not equal to each other!');  
%   end  
 D = Y1 - Y2;   
% end  
MSE = sum(D(:).*D(:)) / numel(Y1);   
PSNR = 10*log10(255^2 / MSE); 
fprintf('PSNR: %.2f dB\n', PSNR);


%Euclidean distance calculation
euclideanDistance = calculateEuclideanDistance(edgeImage,GroundTruthImage);
disp(['Euclidean Distance: ' num2str(euclideanDistance)]);

%Edge strength calculation
 e1 = 1 /MSE*10^4;
 disp(['Edge strength:   ',num2str(e1)]);

image=name;

%Storing all Parameters in one variable
resultData = ([image(:),MSE1(:),RMSE(:),ent_imf(:),truePositives(:),falsePositives(:),trueNegatives(:),falseNegatives(:),acc(:),precision(:),recall(:),F1(:),PSNR(:),euclideanDistance(:),e1(:)]);

%Writing Data to Excel
writeToExcel(excelFileName,varNames,resultData);

%Writing Image to Folder
ModifiedImageName=name;
edgeImageName=strcat("Edge_Of_",name);
writeToFolder(MainFolder,OriginalImage,edgeImage,ModifiedImageName,edgeImageName);