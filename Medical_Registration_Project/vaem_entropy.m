function [Entropy,F] = vaem_entropy (I)
% just grab some image and make it into an example
I = im2uint16(I); % make it uint16
% process it to move the data outside of 2^8 locations
%I = imfilter(I,fspecial('disk',3));
% this is what entropy() does
counts = imhist(I(:),2^16);
numel(counts) % it's using 65536 bins
counts = counts(counts~=0); % get rid of empty bins
numel(counts) % how many bins are left?
counts = counts/numel(I); % normalize the sum
Entropy = -sum(counts.*log2(counts)); % this is the result with 65536 bins
F = entropy(I); % this is the result with 256 bins
end