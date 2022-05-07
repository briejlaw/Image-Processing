function [DC,OC, OR] = overlappingDescriptors(A,B)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function that return values of overlapping between two images
%inputs: A = first image / B = second image
%outputs: DC Dice's Coefficient, OC overlapping coefficients, overlapping ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

modA= sum(A, 'all');
modB=sum(B, 'all');
modAinterB= sum(A&B, "all");

%DC calculation
DC=(2*modAinterB)/(modA +modB);

%OC calculation
OC= modAinterB/(min(modA,modB));

%OR calculation
OR= modAinterB/(modA + modB - modAinterB);

end