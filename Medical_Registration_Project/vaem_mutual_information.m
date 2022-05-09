function mutualInformation = vaem_mutual_information(Entropy_A,Entropy_B,jointEntropy)
%Función que recibe las entropías individuales y la conjunta de dos
%imágenes o volúmenes y devuelve la información mutua.
mutualInformation = Entropy_A + Entropy_B - jointEntropy;
end