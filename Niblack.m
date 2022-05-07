function output_img = Niblack(A, k, size)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function applies the NIBLACK method for the identification of objects
%using thresholds calculated from the mean and standard deviation of pixel 
%neighborhoods.

% Inputs: A = Imagen, k = constant range 0,5 to 1, size = Size of the 
%Neighborhood window size (Recommended 5 to 10).
%outputs: output_img = niblack method image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A_double=im2double(A); % Img original to double
%Use of the averag.m function to calculate the mean of a neighborhood 
% of size (size).
img1_avrg_double = averag(A_double,size);
%Calculation of the standard deviation with sqrt E(X^2)-E_(x)^2
E_x2 = A_double.*A_double; %X^2
img1_E_x2 = averag(E_x2,size); %E(X^2)
img1_E_1x2 = averag(A_double,size).^2; %E_(x)^2
Subs = img1_E_x2 - img1_E_1x2; %E(X^2)-E_(x)^2
Desv_img1 = Subs.^(1/2);%Sqrt
T=(img1_avrg_double + (k * Desv_img1)); %applying NIBLACK
output_img = A_double > T;%Comparison of img original vs img Niblack
% If the gray level of original img > img Niblack; T = assigns 1 in 
%output_img; otherwise 0
end
