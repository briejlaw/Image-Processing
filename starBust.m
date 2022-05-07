function [imgOut] = starBust(I,Cent_point,Num_of_rays,Length_ray,Threshold)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%image segmentation Starburst_function
%inputs:
Img = imgaussfilt(I,1);
col0 = Cent_point(1);
row0 = Cent_point(2);
lon = Length_ray;
num_rays  = Num_of_rays;
th = Threshold;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%outputs: imgOut = image with Starburst method.

%init
titta=360/num_rays;     %Angle of separation between rays
coords=zeros(num_rays,lon,2);   % Array containing the XY coordinates of each pixel within the ray for each ray.
rayos_values=zeros(1,lon);
copy_input_img = Img;
%max_vector = zeros(num_rays,1);
x_vect = [];         % x-coordinates of the points extracted from each ray
y_vect = [];         % y-coordinates of the points extracted from each ray


for i=1:num_rays %% bucle For of lightning generation and its corresponding gray level

    for j=1:lon  %% Extraction of the gray level for each lightning stroke
        x=round(col0+cosd(titta*i)*j);  %X coordinate of each pixel
        y=round(row0+sind(titta*i)*j);   %Y coordinate of each pixel

        coords(i,j,1)=x;
        coords(i,j,2)=y;
        rayos_values(1,j)=Img(y,x);     % Contains the gray level of each ray sample.
        copy_input_img(y,x) = 255; %%To draw the rays

    end
  

    derivative = diff(rayos_values);      % Extracting the first derivative of the vector

    % If the detection threshold is negative (I detect a drop in intensity)
    if th < 0
        derivative1 = -derivative(1,:);
        thresh = -th;

    else 
        derivative1 = derivative(1,:);
        thresh=th;

    end

    % Finding peaks in derivative
    [pks,locs] = findpeaks(derivative1);
    [M,in]= max(pks);

%     figure; hold on;
%     subplot(1,3,1); plot(rayos_values(1,:));
%     subplot(1,3,2); plot(derivative(1,:)); 
%     subplot(1,3,3); plot(derivative1(1,:)); hold on; plot(locs, pks, '*');
%     hold on; plot(locs(in), M, 'o');
%     pause

    %Obteniendo las localizaciones de los picos
    if M>=thresh
        k=locs(in);
    end
    disp(k)
    

    if ~isempty(k)
        x_vect=[ x_vect coords(i,k,1)];
        y_vect=[ y_vect coords(i,k,2)];

    end

end


% Obtaining the binary mask from stored x and y points
BW1 = roipoly(Img,x_vect(1:end),y_vect(1:end));
imgOut = BW1;

figure,
subplot(1,2,1); imshow(copy_input_img,[]);
subplot(1,2,2); imshow(Img,[]);
hold on;
plot(x_vect(1:end),y_vect(1:end),'r--x');

end