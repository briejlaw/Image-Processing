function jointEntropy = vaem_joint_entropy (I1,I2)
% Función que recibe dos volúmenes o imágenes y devuelve la entropía
% conjunta
jointHistogram = vaem_joint_histogram (I1, I2); %Trae el histograma conjunto
jointNormalized = jointHistogram / numel(I1); %Normalización
%Modificación para evitar valores no deseados y formulación de entropía
indNoZero = jointHistogram ~= 0;
jointProb1DNoZero = jointNormalized(indNoZero);
jointEntropy = -sum(jointProb1DNoZero.*log2(jointProb1DNoZero));
end