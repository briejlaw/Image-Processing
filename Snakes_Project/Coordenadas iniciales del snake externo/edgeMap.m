function [M_pts] = edgeMap(Img, method,umbral)
%Funcion que obtiene el mapa de puntos de una imagen dada, se especifica 
% el metodo para obtener el mapa de puntos (tipo string) y el umbral
% para el thresholding.

% Se probaron varios valores de sigma — Standard deviation of Gaussian 
% distribution para el pre y post suavizado obteniendo mejores resutados en
% los que se emplean en cada caso.

%Pre Suavizado de la imagen de entrada (sigma=0.9)
Imgs = imgaussfilt(Img,0.9);

% Mapa de puntos
BW = double(edge(Imgs,method,umbral));

%Post Suavizado del mapa de puntos (sigma=0.6)
M_pts = imgaussfilt(BW,0.6);

figure;
subplot(2,2,1); imshow (Img, []); title("Imagen Original");
subplot(2,2,2); imshow (Imgs, []);title("Imagen Suavizada");
subplot(2,2,3); imshow (BW, []);title("Mapa de puntos de la imagen suavizada");
subplot(2,2,4); imshow (M_pts, []);title("Mapa de puntos suavizado");

end