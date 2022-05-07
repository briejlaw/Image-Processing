function [DC,OC, OR] = overlappingDescriptors(A,B)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function that return values of overlapping between two images
%inputs: A = first image / B = second image
%outputs: DC Dice's Coefficient, OC overlapping coefficients, overlapping ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

modA= sum(A, 'all');
modB=sum(B, 'all');
modAinterB= sum(A&B, "all");

% Calculo de DC
DC=(2*modAinterB)/(modA +modB);

%Calculo OC
OC= modAinterB/(min(modA,modB));

%Calculo OR
OR= modAinterB/(modA + modB - modAinterB);

end