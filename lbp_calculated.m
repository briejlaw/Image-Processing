function [output_img] = lbp_calculated (I, lon)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to extract textures using the lbp method
%inputs: I = image, lon=Neighborhood size, (only one value).
% outputs: output_img = textured image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output_img= nlfilter(I, [lon lon], @lbp_value);
end


function [lbp_value]= lbp_value(n)
%neighborhood size
x=size(n,1);
y=size(n,2);

%Obtaining central pixel
[value] = centralpixval(n);
cen_pixel=value;

%Vector of neighboring values of the central pixel starting at the left end clockwise
v1=n(1,:);   %first_row
v2=n(2:x,y); %last column
v3=n(x,1:y-1);  %last row
v4=n(2:x-1,1);   %first column
 
v3_1= v3(length(v3):-1:1); % v3 clockwise
v4_1= (v4(length(v4):-1:1)); % v4 clockwise
v=[v1, transpose(v2), v3_1, transpose(v4_1)];

%LBP
lbp= v> cen_pixel;

%LBP value
pow_val=2.^[0:length(lbp)-1];

lbp_v= lbp.*pow_val;
lbp_value= sum(lbp_v);

end