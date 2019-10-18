figure(1);
[img,map]=imread('att_faces/s16/6.pgm');
imshow(img,map);
title('Original Image');

figure(2);
img2dct=dct2(img);
imshow(img2dct,map);
title('2D DCT');

figure(3);
imgrecover=idct2(img2dct);
imshow(imgrecover,map);
title('Back to Image');

figure(4);
t1=0.01.*abs(img2dct);
t2=0.01*max(max(abs(img2dct)));
c_hat=255*(log10(1+t1)/log10(1+t2));
imshow(c_hat,map);
title('Log Magnitude of 2-D DCT');