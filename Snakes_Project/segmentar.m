function [BWF,BW, BW1] = segmentar(M_pts,snakeinx,snakeiny, snakeoutx,snakeouty)
A_double=im2double(M_pts);
%se aplica la función roipoly para el primer stroke
BW = roipoly(A_double, snakeoutx, snakeouty);
%se aplica la función roipoly para el segundo stroke
BW1 = roipoly(A_double,snakeinx, snakeiny); 
%se realiza la resta binaria con xor  
BWF=xor(BW,BW1);
%Producto img resultante de la función NIBLACK con la textura de roipoly
figure, imshow(BWF,[]);
end