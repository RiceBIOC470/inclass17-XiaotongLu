%GB comments
1. 80 Main problem is that you need to incorporate a script that finds the indices (or positions) of pixels that exhibit minimal differences in the pixel intensities. 
2)	100
overall: 90



%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 
%PixelValues


img1=imread('img1.tif');
img2=imread('img2.tif');
diffs=zeros(1,length(img1));
for ov=1:length(img1)-1
    pix1=img1(:,(end-ov):end);
    pix2=img2(:,1:(1+ov));
    diffs(ov)=sum(sum(abs(pix1-pix2)))/ov;
end
[~, overlap] = min(diffs);
img_align = [zeros(800, size(img2,2)-overlap+1), img2];
imshowpair(img1, img_align);
%Fourier
img1_fft=fft2(img1);
img2_fft=fft2(img2);
[nr,nc]=size(img2_fft);
CC=ifft2(img1_fft.*conj(img2_fft));
CCabs=abs(CC);
[row_shift,col_shift]=find(CCabs==max(CCabs(:)));
Nr=ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc=ifftshift(-fix(nc/2):ceil(nc/2)-1);
row_shift=Nr(row_shift);
col_shift=Nc(col_shift);
img_shift=zeros(size(img1)+size(img2)-[row_shift,col_shift]);
img_shift((end-(length(img1)-1)):end,(end-(length(img1)-1):end))=img2;
imshowpair(img1,img_shift);
