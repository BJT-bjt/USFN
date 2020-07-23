function [W,F,A,Ls] = SUUSLFN(X, k, c, lambda, m,  Niter)


if nargin < 6
    Niter = 3;
end;
islocal = 1;
r = -1;

[dim,num] = size(X);
[d,n] = size(X);
num = n;
dim = d;
%% 

distX = L2_distance_1(X,X);
%distX = sqrt(distX);
[distX1, idx] = sort(distX,2);
A = zeros(num);
rr = zeros(num,1);
for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    A(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end;

if r <= 0
    r = mean(rr);
end;


A0 = (A+A')/2;
D0 = diag(sum(A0));
L0 = D0 - A0;
[F, temp, evs]=eig1(L0, m, 0);

H = eye(num)-1/num*ones(num);
St = X*H*X';
invSt = pinv(St);
M = (X*L0*X');
W = eig1(M, m, 0, 0);

%% update variable
for iter = 1:Niter
    %% update S
    distf = L2_distance_1(F',F');
    if iter>5
        [temp, idx] = sort(distf,2);
    end;
    A = zeros(num);
    for i=1:num
        if islocal == 1
            idxa0 = idx(i,2:k+1);
        else
            idxa0 = 1:num;
        end;
        dfi = distf(i,idxa0);
        ad = -(dfi)/(2*r);
        A(i,idxa0) = EProjSimplex_new(ad);
    end;

    
    A = (A+A')/2;
    D = diag(sum(A));
    Ls = D-A;
    

        %% update W
    I = eye(size(Ls));
    XL = X*(I - lambda*(Ls + lambda*I)^(-1))*X';
    M = invSt*XL;
    W = eig1(M, m, 0, 0);
    W = W*diag(1./sqrt(diag(W'*W)));

    %% update F
    invLs = inv(Ls + lambda*I);
    F = lambda*invLs*X'*W;

end
end
