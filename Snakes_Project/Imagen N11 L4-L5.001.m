clc;
clear all;

%% Imagen N11 L4-L5.001.DCM

A = dicomread('./Imagenes/N11 L4-L5.001.DCM');

%Llamada a la funcion mapa de puntos 
method='sobel';
umbral=0.001;
M_pts = edgeMap(A, method,umbral);

% Puntos del snake inicial externo de la imagen 
load('./Coordenadas iniciales del snake externo/x_N11 L4-L5_001.mat');
load('./Coordenadas iniciales del snake externo/y_N11 L4-L5_001.mat');
figure, imshow (M_pts, [])
hold on;
plot(x,y);
initsnake_x=x;
initsnake_y=y;

% LLamada a la funcion de obtener las fuerzas 
%Metodo MOG
[FXN,FYN ,FX,FY]= force(M_pts,"MOG");
figure, imshow (M_pts, []);hold on; Q = quiver (FXN,FYN); 

%Llamando a la funcion iterative
ganma=0.9;
alpha=0.05;
beta=0.005;
Numiter=220;
%Snake final externo
[snake_finalx_out,snake_finaly_out] = iterative(M_pts,ganma,alpha,beta,initsnake_x, initsnake_y, FXN,FYN,Numiter);

% Puntos del snake inicial interno de la imagen 
load('./Coordenadas iniciales snake interno/xin_N11 L4-L5_001.mat');
load('./Coordenadas iniciales snake interno/yin_N11 L4-L5_001.mat');
figure, imshow (M_pts, [])
hold on;
plot(x,y);
initsnake_xin=x;
initsnake_yin=y;

%Llamando a la funcion iterative
ganma=0.4;
alpha=0.01;
beta=0.005;
Numiter=85;
%Snake final externo
[snake_finalx_in,snake_finaly_in] = iterative(M_pts,ganma,alpha,beta,initsnake_xin, initsnake_yin , FXN,FYN,Numiter);

%Llamada a la funcion segmentar
[BWF,BW, BW1] = segmentar(M_pts,snake_finalx_in,snake_finaly_in, snake_finalx_out,snake_finaly_out);

% Overlapping descriptors
B= imread('./GT/GT N11 L4-L5.001.tif');

[DC,OC,OR] = overlappingDescriptors(BWF,B);
figure, subplot (1,2,1); imshow(BWF,[]); title('Resultado'); subplot (1,2,2); imshow(B,[]); title('Modelo')

%% LLamada a la funcion de obtener las fuerzas 
%Metodo GVF, 
Num_Iter=100;
[FXN1,FYN1 ,FX1,FY1]= force(M_pts,"GVF", Num_Iter);

%Llamando a la funcion iterative
ganma=0.9;
alpha=0.05;
beta=0.005;
Numiter1=20;
%Snake final externo
[snake_finalx_out1,snake_finaly_out1] = iterative(M_pts,ganma,alpha,beta,initsnake_x, initsnake_y, FXN1,FYN1,Numiter1);

%obtener snake interno
ganma=0.3;
alpha=0.0001;
beta=0.05;
Numiter1=45;
%Snake final externo
[snake_finalx_in1,snake_finaly_in1] = iterative(M_pts,ganma,alpha,beta,initsnake_xin, initsnake_yin, FXN1,FYN1,Numiter1);

%Llamada a la funcion segmentar
[BWF_f,BW_f, BW1_f] = segmentar(M_pts,snake_finalx_in1,snake_finaly_in1, snake_finalx_out1,snake_finaly_out1);

%Overlapping descriptors
[DC_f,OC_f, OR_f] = overlappingDescriptors(BWF_f,B);
figure, subplot (1,2,1); imshow(BWF_f,[]); title('Resultado'); subplot (1,2,2); imshow(B,[]); title('Modelo');

