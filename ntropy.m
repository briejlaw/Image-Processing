function [I_ntropy] = ntropy(I,dimx,dimy)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%entropy function of an image
%inputs: I = image, dimx - dimy: I dimensions.
%outputs: [I_ntropy] = image entropy.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fun = @(x) entropy(x(:));
I_ntropy=nlfilter(I,[dimx, dimy],fun);

end

