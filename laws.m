function final=laws(A, var)

%Law Texture Energy (LTE) function to extract texture features  from an image, 
% through the convolution of 5x5 masks (each mask extracts a particular feature 
% from the image). As a result of the convolution, 25 masks are obtained;
% after joining the concordant masks, will be reduced to 9 masks. 
% Concordant-ejem: L5E5 measures the content of the vertical edges and E5L5 
% the content of the horizontal ones. The average of both becomes the total 
% edge content.


%A = image
%var = number 1 --> 9 (masks)

% 5x5 masks defined
L5=[ 1 4 6 4 1]; %(niveles)
E5=[-1 -2 0 2 1]; %(bordes)
S5=[-1 0 2 0 -1]; %(spot)
W5=[-1 2 0 -2 1]; %(ondas)
R5=[1 -4 6 -4 1]; %(ripple)

%Mask Convolution
L5E5mask=L5'*E5;
E5L5mask=E5'*L5;
L5R5mask=L5'*R5;
R5L5mask=R5'*L5;
E5S5mask=E5'*S5;
S5E5mask=S5'*E5;
S5S5mask=S5'*S5;
R5R5mask=R5'*R5;
L5S5mask=L5'*S5;
S5L5mask=S5'*L5;
E5E5mask=E5'*E5;
E5R5mask=E5'*R5;
R5E5mask=R5'*E5;
S5R5mask=S5'*R5;
R5S5mask=R5'*S5;

%Structure to join concordant pairs and call the result in the function.
%the two matching pairs are added together and divided by 2.

switch var
    case 1
       mask = (L5E5mask + E5L5mask)/2;
    case 2
        mask = (L5R5mask + R5L5mask)/2;
    case 3 
        mask = (E5S5mask + S5E5mask)/2;
    case 4
        mask = (S5S5mask + S5S5mask)/2;
    case 5 
        mask=R5'*R5;
    case 6 
        mask = (L5S5mask + S5L5mask)/2;
    case 7 
        mask=E5'*E5;
    case 8 
        mask = (E5R5mask + R5E5mask)/2;
    case 9 
        mask = (S5R5mask + R5S5mask)/2;
    otherwise
        error('Opción incorrecta. Ingresa un número válido');
end

%Conversion to double
A_double=im2double(A);
%imfilter function application
final= imfilter(A_double,mask);




    