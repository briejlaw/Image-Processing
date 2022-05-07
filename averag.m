function img_averag = averag(I,h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function that applies a spatially averaged filter to an image
%inputs: I = Image, h = value of an image dimension (dimx or dimy).
%outputs: img_averag = smooth image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

avrg=fspecial('average',h);
img_averag=imfilter(I,avrg);

end

