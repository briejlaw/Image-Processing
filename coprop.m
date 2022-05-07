function I_prop = coprop(I,dimx,dimy,n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%inputs: I = imagen, dimx-dimy = image dimension, n = 1 to 4.
%outputs: I_prop = image with applied methods.
%n=1 return img_contraste | n=2 return img_correlacion
%n=3 return img_energía   | n=4 return img_homogeneidad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch n
    case 1
        prop="Contrast";
    case 2
        prop="Correlation";
    case 3
        prop="Energy";
    case 4
        prop="Homogeneity";
end
    

    function value = calculateProperty(x)
        glcm = graycomatrix(x,'Offset',[1 0],'GrayLimits',[]);
        stats = graycoprops(glcm,{char(prop)});
        
        switch n
            case 1
                value = stats.Contrast;
            case 2
                value = stats.Correlation;
            case 3
                value = stats.Energy;
            case 4
                value = stats.Homogeneity;
        end
    end

    fun=@calculateProperty;
    I_prop = nlfilter(I,[dimx dimy], fun);
    
end