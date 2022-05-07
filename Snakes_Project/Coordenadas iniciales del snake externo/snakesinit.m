clear all;
clc;

%Scripts donde se obtienen los snake iniciales externos de cada imagen.

%% Imagen OV2 L3-L4_0.dcm
A = dicomread('./Imagenes/N3 L2-L3.DCM');
figure; imshow (M_pts, [])
hold on
plot(1:2,1:2,'s');
hold on
[x,y] = myginput(50,'crosshair');
plot(x,y,'o');
hold off 
%Completar el snake
x=[x; x(1,1)];
y=[y; y(1,1)];

%%