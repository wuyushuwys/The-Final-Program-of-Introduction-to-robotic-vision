function [ s ] = CalculateSolution(EssentialMatrix)
[U,S,V] = svd(EssentialMatrix);
if det(V) < 0
    V = -V;
    S = -S;
end
if det(U) < 0
    U = -U;
    S = -S;
end
R1 = U*rotz(pi/2)'*V';
R2 = U*rotz(-pi/2)'*V';
t1 = vex(U*rotz(pi/2)*S*U');
t2 = vex(U*rotz(-pi/2)*S*U');
% invert (R,t) so its from camera 1 to 2
s(1) = SE3( inv( [R1 t1; 0 0 0 1] ) );
s(2) = SE3( inv( [R2 t2; 0 0 0 1] ) );
end