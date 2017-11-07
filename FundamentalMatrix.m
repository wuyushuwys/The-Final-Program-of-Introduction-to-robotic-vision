inner = m.inlier;
n = size(inner, 2);
if n>7
    temp1 = zeros(4, n);
    P1 = zeros(2, n);
    P2 = zeros(2, n);
    for i = 1:n
        temp1(:,i) = inner(i).xy_;
        P1(:, i) = temp1(1:2, i);
        P2(:, i) = temp1(3:4, i);
    end
    F = fmatrix(P1, P2);
else
    disp('Not enough matched points and you have to load other couple of picture')
end
