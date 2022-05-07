function [BWF,BW, BW1] = segmenting(M_pts,snakeinx,snakeiny, snakeoutx,snakeouty)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This function receives a preprocessed image and the strokes marked on 
% the image. 
%inputs: M_pts = preprocessed image; snakein, snakeiny = internal strokes
%snakeoutx, snakeouty = external strokes
%outputs = segmented image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


A_double=im2double(M_pts);
%applying  the roipoly function for the first stroke
BW = roipoly(A_double, snakeoutx, snakeouty);
%applying  the roipoly function for the second stroke
BW1 = roipoly(A_double,snakeinx, snakeiny); 
%binary subtraction is performed with xor  
BWF=xor(BW,BW1);
figure, imshow(BWF,[]);
end