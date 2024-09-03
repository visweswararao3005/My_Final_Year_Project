function[imf] = fpdctf(im1,im2,f)
% Freqency partition 1D DCT based image fusion
% Developed by : VPS Naidu, MSDF Lab

imfr = mrdctif(im1,im2,f);
imfc = mrdctif(im1',im2',f)';%figure(4); imshow(imfc,[])
%imf = 0.5*(imfr+imfc);
imfmax = max(imfr,imfc);
imfmin = min(imfr,imfc);
imf = 0.5*(imfmax+imfmin);
% 
% C = cov([imfr(:) imfc(:)]);       %PCA Fusion Rule
% 
% %[V, D] = eigs(C,'lm');
% [V, D] = eigs(C);
% if D(1,1) >= D(2,2)
%   pca = V(:,1)./sum(V(:,1));
% else  
%   pca = V(:,2)./sum(V(:,2));
% end
% 
% 
% % fusion
% imf = pca(1)*imfr + pca(2)*imfc;

% addpath(genpath('lib'));
% 
% addpath(genpath('imageFusionMetrics-master_modified'));
% 
% addpath(genpath('sparsefusion'));
% addpath(genpath('nsct_toolbox'));
% addpath(genpath('fdct_wrapping_matlab'));
% addpath(genpath('dtcwt_toolbox'));



%load('Dictionary/D_100000_256_8.mat');

%load('sparsefusion/Dictionary/D_100000_256_8.mat');
% 
% overlap = 6;                    
% epsilon=0.1;
%load('Dictionary/D_100000_256_8.mat');

%imf=sparse_fusion(imfr,imfc,D,overlap,epsilon);
% 
% 
% 
% overlap = 6; %---- this is actual overlap value
% %overlap = 1;                    
% epsilon=0.1;
 %level=7;

%imf = dtcwt_sr_fuse(imfr,imfc,level,D,overlap,epsilon);      %DTCWT-SR
%imf = nsct_sr_fuse(imfr,imfc,[2,3,3,4],D,overlap,epsilon);   %NSCT-SR
%imf = nsct_fuse(im1,im2,[2,3,3,4]);        %NSCT
%imf = nsct_fuse(im1,im2,level);        %NSCT

% imf = curvelet_sr_fuse(imfr,imfc,level+1,D,overlap,epsilon); %CVT-SR

%imf = dtcwt_fuse(imfr,imfc,level);           %DTCWT

%imf = dwt_fuse(im1, im2, level);           %DWT

%imf = swt_fuse(im1,im2,level);           %DTCWT





function[imf] = mrdctif(im1,im2,f)
[m,n] = size(im1);
f = round(m*n*f);
mr1 = mrdct(im1,m,n);
mr2 = mrdct(im2,m,n);
D = (abs(mr1)-abs(mr2)) >= 0;
IMFR = D.*mr1 + (~D).*mr2;
IMFR(1:f) = 0.5*(mr1(1:f)+mr2(1:f));



%IMFR(1:f) = min(mr1(1:f),mr2(1:f));
imf = imrdct(IMFR,m,n);

function[IMR] = mrdct(im,m,n)
mn = m*n;
R = im; 
R(2:2:end,:)=R(2:2:end,end:-1:1);
R = reshape(R',1,m*n);
IMR = dct(R,mn);


function[R] = imrdct(R,m,n)
mn = m*n;
imhr = idct(R,mn);
R = reshape(imhr,n,m)';
R(2:2:end,:)=R(2:2:end,end:-1:1);
