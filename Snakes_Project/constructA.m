function matrixA = constructA(alpha, beta, x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function that creates the pentadiagional matrix
%inputs: alpha = (snake point control constant).
%beta = (snake bending constant).
% x = Dimension of points.
%outputs: 
%A = pentadiagonal banded matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = numel(x); %returns the number of x elements.
N1 = N-1;
N2 = N-2;
% construct matrix D2.
l = ones(N,1)*-2;%column vector - 2
z = ones(N1,1);%column vector 1
D2 = diag(l) + diag(z,-1) + diag(z,1);%diag places the vectors according to the required order
D2(1,N) = 1; D2(N,1) = 1; %puts 1 on edges
% construct matrix D4.
a = ones(N,1)*6;%column vector 6
b = ones(N1,1)*-4;%column vector -4
c = ones(N2,1);%column vector 1
D4 = diag(a) + diag(b,-1) + diag(b,1) + diag(c,-2) + diag(c,2);%diag places the vectors according to the required order
D4(1,N) = -4; D4(N,1) = -4; D4(1,N1) = 1; D4(N1,1) = 1; D4(2,N) = 1; D4(N,2) = 1; %puts valors on edges
% Construct final matrix A. 
%A = [I-D]^-1
D = alpha*D2 - beta*D4; %by calculating D
I = eye(N); %KxK identity matrix.
A = I - D; %by calculating A.
matrixA = inv(A); %inverse of A.


end 