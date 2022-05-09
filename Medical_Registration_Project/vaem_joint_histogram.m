function jointHistogram = vaem_joint_histogram (I1, I2)
%Función que recibe dos volúmenes o imágenes y devuelve su histograma
%conjunto
I1max= max(I1(:)); %Adaptación de las dimensiones
I2max= max(I2(:));
[jointHistogram,Xedges,Yedges] = histcounts2(I1,I2,[I1max I2max]);
%figure, histogram2('XBinEdges',Xedges,'YBinEdges',Yedges,'BinCounts',jointHistogram,'EdgeColor','k');

end
