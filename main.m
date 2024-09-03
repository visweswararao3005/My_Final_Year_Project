clc;clear;close all;home;

addpath(genpath('lib'));
addpath(genpath('imageFusionMetrics-master_modified'));
addpath(genpath('sparsefusion'));
addpath(genpath('nsct_toolbox'));
addpath(genpath('fdct_wrapping_matlab'));
addpath(genpath('dtcwt_toolbox'));
addpath(genpath('Medical Data'));
addpath(genpath('Dataset'));

% im=imread('Dataset\IMG\c1.jpg');
% i1=imread('Dataset\LB\c1_LB.jpg');
% i2=imread('Dataset\RB\c1_RB.jpg');
% gt=imread('Dataset\GT\c1_GT.jpg');

% Get the current directory
currentFolder = fileparts(mfilename('fullpath'));

% Construct the full path to the image folder
imgFolder = fullfile(currentFolder, 'Medical Data');
 % Open a file dialog for original image selection
[filename1, pathname1] = uigetfile('*.*' , 'Select an Image File',imgFolder);
% Build the full file path
filePath1 = fullfile(pathname1, filename1);originalImage=imread(filePath1);
% Check if the image is color or grayscale
if size(originalImage, 3) == 3
   originalImage = rgb2gray(originalImage);
end

imgFolder = fullfile(currentFolder, 'Medical Data');
     % Open a file dialog for Fused image selection
[filename2, pathname2] = uigetfile('*.*' , 'Select an multifocus image 1 File',imgFolder);
     % Build the full file path
filePath2 = fullfile(pathname2, filename2);i1=imread(filePath2);
% Check if the image is color or grayscale
if size(i1, 3) == 3
   i1 = rgb2gray(i1);
end

imgFolder = fullfile(currentFolder, 'Medical Data');
     % Open a file dialog for Ground Truth image selection
[filename3, pathname3] = uigetfile('*.*' , 'Select an multifocus image 2 File',imgFolder);
     % Build the full file path
filePath3 = fullfile(pathname3, filename3);i2=imread(filePath3);
% Check if the image is color or grayscale
if size(i2, 3) == 3
   i2 = rgb2gray(i2);
end

imgFolder = fullfile(currentFolder, 'Medical Data');
     % Open a file dialog for Ground Truth image selection
[filename4, pathname4] = uigetfile('*.*' , 'Select an Ground Truth  Image File',imgFolder);
     % Build the full file path
filePath4 = fullfile(pathname4, filename4);gt=imread(filePath4);

% Check if the user canceled the file selection
if isequal(filename1, 0) || isequal(pathname1, 0) ||isequal(filename2, 0) || isequal(pathname2, 0) || isequal(filename3, 0) || isequal(pathname3, 0) || isequal(filename4, 0) || isequal(pathname4, 0)
    disp('User canceled image selection.');
    return;
end

% convert images to double
img=double(originalImage);
im1=double(i1);
im2=double(i2);
imgt=double(gt);

% Fused Image
imf = fpdctf(im1,im2,0.0);
imf1 = cast(imf,'uint8');

[a,b] = size(gt);
img = imresize(originalImage, [a,b]);
im1 = imresize(i1 , [a,b]);
im2 = imresize(i2 , [a,b]);
imf1 = imresize(imf1 , [a,b]);

a=input("Enter 1 for Existing values\nEnter 2 for Proposed values\n  :->   ");

% Setup Excel file name (PROPOSED,EXISTING) 
excelFileName = input('Enter Excel sheet name:(PROPOSED,EXISTING) (.xlsx): ', 's');    

% Create the parent folder
MainFolder = input('Enter Folder name:(PROPOSED,EXISTING) : ', 's');
mkdir(MainFolder);

%fprintf('Original Image Values\n');
name=strcat("Original_Image.jpg");
parameters(a,originalImage,gt,excelFileName,1,0,name,MainFolder);

%fprintf('\nFused Image Values\n');
name=strcat("Fused_Image.jpg");
parameters(a,imf1,gt,excelFileName,2,0,name,MainFolder)

for i=0:5:50
     %fprintf("\n noise = %0.01f",i);
     name=strcat("Original_With_Noise(",num2str(i),").jpg");
     
     maxv=double(intmax('uint8'));
     ns=(i/100)*maxv;
     modifiedImage=imnoise(img,'gaussian',0,(ns^2)/(maxv^2));

     parameters(a,modifiedImage,gt,excelFileName,3,i,name,MainFolder);
end

for i=0:5:50
     %fprintf("\nFused with noise = %0.01f",i)
     name=strcat("Fused_With_Noise(",num2str(i),").jpg");
     
     maxv=double(intmax('uint8'));
     ns=(i/100)*maxv;
     modifiedImage=imnoise(imf1,'gaussian',0,(ns^2)/(maxv^2));
    
     parameters(a,modifiedImage,gt,excelFileName,4,i,name,MainFolder);
end

for i=0:5:50
     %fprintf("\nFilter for noise = %0.01f image",i);
     name=strcat("Filter_For_Original_Image_With_Noise(",num2str(i),").jpg");

     maxv=double(intmax('uint8'));
     ns=(i/100)*maxv;
     modifiedImage=imnoise(img,'gaussian',0,(ns^2)/(maxv^2));

     gaussianFilter = fspecial('gaussian', [5 5], 2);
     img1=imfilter(modifiedImage, gaussianFilter, 'conv'); 
    
     parameters(a,img1,gt,excelFileName,5,i,name,MainFolder);
end

for i=0:5:50
     %fprintf("\nFilterForFusedImageWithNoise = %0.01f",i)
     name=strcat("Filter_For_Fused_Image_With_Noise(",num2str(i),").jpg");

     maxv=double(intmax('uint8'));
     ns=(i/100)*maxv;
     modifiedImage=imnoise(imf1,'gaussian',0,(ns^2)/(maxv^2));

     gaussianFilter = fspecial('gaussian', [5 5], 2);
     img1=imfilter(modifiedImage, gaussianFilter, 'conv');
     parameters(a,img1,gt,excelFileName,6,i,name,MainFolder);
end