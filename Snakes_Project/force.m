function [FXN,FYN ,FX,FY] = force(M_pts,metodo, Num_Iter)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function to calculate the force according to the MOG or GFV method, 
% in this last one the number of iterations must be specified.
%inputs: M_pts = preprocessed; metodo = MOG or GFV; num_Iter = number of 
%loop iterations
%outputs = FXN, FYN = normalized forces; FX, FY = forces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if (exist('Num_Iter', 'var')) 
     N= Num_Iter;
 end

 if (metodo=="MOG")
     %Gradiente de mi imagen de puntos
     [FX,FY] = gradient(M_pts);
 end

 if (metodo=="GVF")
     [FX1,FY1] = gradient(M_pts);
     initv_x=FX1;
     initv_y=FY1;
     deriv_x=FX1;
     deriv_y=FY1;
     mu=0.25; %0.25
     modGrad2= FX1.^2+FY1.^2;
     
     for i=1:N %100 optimo
         finalv_x= mu*del2(initv_x)- modGrad2.*(initv_x-deriv_x)+initv_x;
         finalv_y=mu*del2(initv_y)- modGrad2.*(initv_y-deriv_y)+initv_y;
         initv_x= finalv_x;
         initv_y= finalv_y;
         FX=initv_x;
         FY=initv_y;
     end
 end

 % Normalized force
Fgrad = sqrt(FX.^2 + FY.^2);
FXN = FX./(Fgrad + eps);
FYN = FY./(Fgrad + eps);

end