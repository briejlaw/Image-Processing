function jointEntropy = vaem_joint_entropy (I1,I2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function that receives two volumes or images and returns the entropy
%joint
%inputs: I1,I2 = volumes or images
%outputs: jointEntropy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

jointHistogram = vaem_joint_histogram (I1, I2); %Get the joint histogram
jointNormalized = jointHistogram / numel(I1); %Normalization
%Modification to avoid unwanted values and entropy formulation
indNoZero = jointHistogram ~= 0;
jointProb1DNoZero = jointNormalized(indNoZero);
jointEntropy = -sum(jointProb1DNoZero.*log2(jointProb1DNoZero));
end