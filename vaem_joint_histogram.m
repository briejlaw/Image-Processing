function jointHistogram = vaem_joint_histogram (I1, I2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function that receives two volumes or images and returns their joint 
%histograms
%inputs: I1,I2 = volumes or images
%outputs:jointHistogram 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I1max= max(I1(:)); %Adaptation of dimensions
I2max= max(I2(:));
[jointHistogram,Xedges,Yedges] = histcounts2(I1,I2,[I1max I2max]);
%figure, histogram2('XBinEdges',Xedges,'YBinEdges',Yedges,'BinCounts',jointHistogram,'EdgeColor','k');

end
