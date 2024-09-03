%Frequency Partition (FP) fusion technique
 
clear ;
close all;
clc;
home;

addpath(genpath('lib'));
addpath(genpath('imageFusionMetrics-master_modified'));
addpath(genpath('sparsefusion'));
addpath(genpath('nsct_toolbox'));
addpath(genpath('fdct_wrapping_matlab'));
addpath(genpath('dtcwt_toolbox'));
addpath(genpath('Medical_Data'));
addpath(genpath('Bio_Medical_Images'));

% im=imread('Dataset\c1.jpg');
% i1=imread('Dataset\c1_LB.jpg');
% i2=imread('Dataset\c1_RB.jpg');
% gt=imread('Dataset\c1_GT.jpg');


% Get the current directory
%currentFolder = fileparts(mfilename('fullpath'));

% Construct the full path to the image folder
imgFolder = fullfile('Bio_Medical_Images');
% Open a file dialog for image selection
[filename, pathname] = uigetfile('*.*' , 'Select an Image File',imgFolder);
%Build the full file path
filePath = fullfile(pathname, filename);
im=imread(filePath);
% Check if the image is color or grayscale
if size(im, 3) == 3
   im = rgb2gray(im);
end


imgFolder = fullfile('Bio_Medical_Images');
[filename1, pathname1] = uigetfile('*.*' , 'Select an multifocus image 1 File',imgFolder);
% Build the full file path
filePath1 = fullfile(pathname1, filename1);
i1=imread(filePath1);

imgFolder = fullfile('Bio_Medical_Images');
[filename2, pathname2] = uigetfile('*.*' , 'Select an multifocus image 2 File',imgFolder);
% Build the full file path
filePath2 = fullfile(pathname2, filename2);
i2=imread(filePath2);

imgFolder = fullfile('Bio_Medical_Images');

[filename3, pathname3] = uigetfile('*.*' , 'Select an Ground Truth image File',imgFolder);
% Build the full file path
filePath3 = fullfile(pathname3, filename3);
gt=imread(filePath3);

b=split(filename,'.');
folder=b(1);
excel=append(b(1),'.xlsx');

% convert images to double
img=double(im);
im1=double(i1);
im2=double(i2);
imgt=double(gt);

% Making all input images of same size  
[a,b] = size(imgt);
img = imresize(img, [a,b]);
im1 = imresize(im1, [a,b]);
im2 = imresize(im2, [a,b]);

% Check if the user canceled the file selection
if isequal(filename, 0) || isequal(pathname, 0) ||isequal(filename1, 0) || isequal(pathname1, 0) ||isequal(filename2, 0) || isequal(pathname2, 0) || isequal(filename3, 0) || isequal(pathname3, 0)
    disp('User canceled image selection.');
    return;
end

% Fuse Image
f =0.0;%[0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]; %frquency partition factor (bt. 0 to 1)
% arr=['A';'B'];
% for m=1:2
%    string=arr(m);
%     inp_image=strcat('images\Imed300',string,'.jpg');
% %    inp_image=strcat('images\office256',string,'.tif');
% %    inp_image=strcat('images\gun',string,'.gif');
% %    inp_image=strcat('lampicka01',string,'.png');
% 
%    x{m}=imread(inp_image);
%    if(size(x{m},3)==3)
%       x{m}=rgb2gray(x{m});
%    end
% end
% [M,N]=size(x{m});
%im2 = rgb2gray(im2);
% im1=dct(im1);
% im2=dct(im2);
% image fusion
for i=1:1%length(f)
 imf = fpdctf(im1,im2,f(i));
 %imf=idct(imf);
 %imf = SML(imf);
 imf1=cast(imf,'uint8');
 imwrite(imf1,'c6_FU.tif','tif')
 %imf = imf-min(imf(:));
end

%%%%%% Setup Excel file name (PROPOSED,EXISTING) %%%% 
excelFileName =excel{1};% input('Enter Excel sheet name:(PROPOSED,EXISTING) (.xlsx): ', 's');    

% Create the parent folder
MainFolder = folder{1} ; % input('Enter Folder name:(PROPOSED,EXISTING) : ', 's');
mkdir(MainFolder);

edges1=existing_canny_edge_detection(im);
%edges1 = canny_edge_detection(im);
name="EX_Image.jpg";
parameters( edges1 , im , gt , name , excelFileName , MainFolder )


edges2=proposed_sobelEdgeDetection(imf1);
%edges2= robertEdgeDetection(imf1);
name="PO_Fused_Image.jpg";
parameters( edges2 , imf1 , gt , name , excelFileName , MainFolder )

figure()
subplot(2,5,1);imshow(i1);title("multifocus image 1");
subplot(2,5,2);imshow(i2);title("multifocus image 2");

subplot(2,5,4);imshow(im);title("Original Image ");
subplot(2,5,5);imshow(imf1);title("Fused Image");

subplot(2,5,6);imshow(gt);title("Ground Truth Image");
subplot(2,5,7);imshow(edges1);title("Existing Edges for Original Image");

subplot(2,5,10);imshow(edges2);title("Proposed Edges for Fused Image");

%END OF MAIN CODE
% 
%  ent_imf=entropy(uint8(imf))
%  
%  mn_imf=mean(mean(double(imf)))
% %  e=imt-imf;ent_e=entropy(uint8(e));
% %  figure(6); imshow(e,[])
%  per_met2 = perevalwt(imf);
%  per_met3 = pereval(imt,abs(imf));
%  Q_ABF = Qp_ABF(im1,im2,imf)
%  Q_abfe = Qabf_eval(im1,im2,imf)
% 
%  %Mean Square Error
%  MSE = MeanSquareError(imt, imf)
%  %Normalized Cross-Correlation 
%  NK = NormalizedCrossCorrelation(imt, imf)
%  %Average Difference 
%  AD = AverageDifference(imt, imf)
%  %Maximum Difference 
%  MD = MaximumDifference(imt, imf)
%  %Normalized Absolute Error
%  NAE = NormalizedAbsoluteError(imt, imf)
% 
%  fusion_perform_fn(imf,imt);
%  %objective_fusion_perform_fn(imf,x)
% 
%  %ECC = fusionECC(im1,im2,imf)
% 
% %  [FSIM, FSIMc] = FeatureSIM(imt, imf)
% % 
% %  vifp_k = kun_vifp_mscale(imt,imf)
% % 
% %  NQM_k = kun_NQM_FR(imt,imf)
% 
%  
%  % e=imt-imf;
%  % RMSE = mean(e(:).^2);%root mean square error
%  % % for i=1:k
%  % %     figure(5+i);
%  % %     imshow(Idf{i},[]);%laplacian images
%  % % end
%  % fprintf('RMSE=%f\n',RMSE);
% 
% %  brisque_imt = brisque(imt)   % A smaller score indicates better perceptual quality. 
% %  brisque_imf = brisque(imf)
% 
% 
%  % model = brisqueModel
%  % score = brisque(imf,model)
% 
% 
% %  niqe_imt = niqe(imt)
% %  niqe_imf = niqe(imf)   %A smaller score indicates better perceptual quality.
% 
% 
% %  setDir = fullfile(toolboxdir('images'),'imdata');
% %  imds = imageDatastore(setDir,'FileExtensions',{'.jpg'});
% %  model = fitniqe(imds);
% %  fitniqe_imt = niqe(imt,model)
% %  fitniqe_imf = niqe(imf,model)
% % 
% %  % setDir = fullfile(toolboxdir('images'),'imdata');
% %  % imds = imageDatastore(setDir,'FileExtensions',{'.jpg'});
% %  % model = fitniqe(imds,'BlockSize',[48 96])
% %  % niqeimt = niqe(imt,model)
% %  % niqeimf= niqe(imf,model)
% % 
% % 
% % 
% %  model = niqeModel
% %  niqeModel_imt = niqe(imt,model)
% %  niqeModel_imf = niqe(imf,model)
% 
% nfmi = fmi(im1,im2,imf,'none',3)
% % % Or simply:
% % nfmi = fmi(ima,imb,imf);
% 
% % [q_S q_S_map] = piella_metric_q_s(im1,im2,imf);
% % fprintf('Piella metric Q_S: \n %f\n',q_S);
% 
% % [q_W q_W_map] = piella_metric_q_w(im1,im2,imf);
% % fprintf('Piella metric Q_W (weighted fusion quality index): \n %f\n',q_W);
% 
% q_S = piella_metric_q_s(im1,im2,imf)
% 
% q_W = piella_metric_q_w(im1,im2,imf)
% 
% q_E1 = piella_metric_q_e1(im1,im2,imf)
% 
% q_E2 = piella_metric_q_e2(im1,im2,imf)
% 
% q_C = cvejic_metric_q_c(im1,im2,imf)
% 
% q_Y = yang_metric_q_y(im1,im2,imf)
% 
% cq_M = pistonesi_metric_cq_m(im1,im2,imf)
% 
% 
% % [q_E1 q_E1_map]= piella_metric_q_e1(im1,im2,imf);
% % fprintf('Piella metric Q_E1 (edge-dependent fusion quality index (version 1)): \n %f\n',q_E1);
% % 
% % [q_E2 q_E2_map]= piella_metric_q_e2(im1,im2,imf);
% % fprintf('Piella metric Q_E2 (edge-dependent fusion quality index (version 2)): \n %f\n',q_E2);
% % 
% % [q_C q_C_map] = cvejic_metric_q_c(im1,im2,imf);
% % fprintf('Cvejic metric Q_C: \n %f\n',q_C);
% % 
% % [q_Y q_Y_map]= yang_metric_q_y(im1,im2,imf);
% % fprintf('Yang metric Q_Y: \n %f\n',q_Y);
% % 
% % [cq_M cq_M_map]= pistonesi_metric_cq_m(im1,im2,imf); 
% % fprintf('Pistonesi metric CQ_M: \n %f\n',cq_M);
% % 
% % 
% % %res = fusionAssess(im1,im2,imf)
% % 
% % 
% % 
% 
% % normalized mutual informtion $Q_{MI}$
%     QMI=metricMI(im1,im2,imf,1)
%     
%     % Tsallis entropy $Q_{TE}$
%     QTE=metricMI(im1,im2,imf,3)
% 
%     % Wang - NCIE $Q_{NCIE}$
%     QNCIE=metricWang(im1,im2,imf)
%     
%     % Xydeas $Q_G$
%     QG=metricXydeas(im1,im2,imf)
%     
%     % PWW $Q_M$
%     QM=metricPWW(im1,im2,imf)
%     
%     % Yufeng Zheng (spatial frequency) $Q_{SF}$
%     % QSF=metricZheng(im1,im2,imf)
%     
%     % Zhao (phase congrency) $Q_P$
%     QP=metricZhao(im1,im2,imf)
%     
%     % Piella  (need to select only one) $Q_S$
%     % Q(i,8)=index_fusion(im1,im2,fused);
%     % QS=metricPeilla(im1,im2,imf,1)
%     
%     % Cvejie $Q_C$
%     % QC=metricCvejic(im1,im2,imf,2)
%     
%     % Yang $Q_Y$
%     % QY=metricYang(im1,im2,imf)
%     
%     % Chen-Varshney $Q_{CV}$
%     QCV=metricChen(im1,im2,imf)
%       
%     % Chen-Blum $Q_{CB}$
%     QCB=metricChenBlum(im1,im2,imf)
%  
%      scd=SCD(im1,im2,imf)