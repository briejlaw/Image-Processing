function mutualInformation = vaem_mutual_information(Entropy_A,Entropy_B,jointEntropy)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function that receives the individual and joint entropies of two
%images or volumes and returns the mutual information.
%inputs: Entropy_A,Entropy_B = entropy of images, jointEntropy
%outputs:mutualInformation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mutualInformation = Entropy_A + Entropy_B - jointEntropy;
end