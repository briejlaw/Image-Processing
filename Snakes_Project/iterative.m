function [snake_finalx,snake_finaly] = iterative(M_pts,ganma,alpha,beta,initsnake_x, initsnake_y, FXN,FYN,Numiter)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function for updating coordinates using the snakes method.
%inputs:  M_pts = preprocessed; [gamma,alpha,beta] = constants 
% initsnake_x, initsnake_y = strokes, FXN,FYN = forces ,Numiter =  number of 
%loop iterations
%outputs: snake_finalx,snake_finaly = final snake positions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matrixA = constructA(alpha, beta, initsnake_x);

for i=1:Numiter
    figure;
    imshow (M_pts, [])
    hold on;
    plot(initsnake_x,initsnake_y,'y')
    %pause;
    FX_x=interp2(FXN,initsnake_x,initsnake_y); 
    FY_y=interp2(FYN,initsnake_x,initsnake_y);
    
    final_snakex=matrixA*(initsnake_x +ganma*FX_x);
    final_snakey=matrixA*(initsnake_y +ganma*FY_y);
    [pt] = interparc(size(initsnake_x,1),final_snakex,final_snakey,'linear');
    
    initsnake_x=[pt(1:size(initsnake_x,1)-1,1); pt(1,1)];
    initsnake_y=[pt(1:size(initsnake_y,1)-1,2); pt(1,2)];
    snake_finalx=initsnake_x;
    snake_finaly=initsnake_y;
    
 end
end