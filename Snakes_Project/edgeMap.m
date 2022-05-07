function [M_pts] = edgeMap(Img, method,umbral)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function that obtains the point map of a given image, specifies the method
% to obtain the point map (string type) and the threshold. 
% the method for obtaining the point map (string type) and the threshold for thresholding.
% for thresholding.

%Several values of sigma - Standard deviation of Gaussian 
% distribution for the pre and post smoothing obtaining better results in
% those used in each case.
%inputs: img = image, method, umbral
%outputs: preprocessed image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pre-smoothing of the input image  (sigma=0.9)
Imgs = imgaussfilt(Img,0.9);

% Points map
BW = double(edge(Imgs,method,umbral));

%Post Point map smoothing (sigma=0.6)
M_pts = imgaussfilt(BW,0.6);

figure;
subplot(2,2,1); imshow (Img, []); title("Imagen Original");
subplot(2,2,2); imshow (Imgs, []);title("Imagen Suavizada");
subplot(2,2,3); imshow (BW, []);title("Mapa de puntos de la imagen suavizada");
subplot(2,2,4); imshow (M_pts, []);title("Mapa de puntos suavizado");

end