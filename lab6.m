% переобуславливатель матрицы
clc; clear;

n = 7;
N = n^2;
A = gallery('poisson',n);% + eye(N,N)*10;
f = rand(N,1);
eps = 1.e-5;
k_max = 10000;

%  якоби
B = diag(diag(A));
invB = inv(B);

D = invB*A;
g = invB* f;
x = zeros(N, 1);
k1 = 0;
r = D*x - g;
err = norm(r)/norm(g);

while (err > eps && k1 < k_max)
   Ar = A*r;
   tau = (r'*r)/((Ar')*r);
   x = x - tau*r;
   r = D*x - g;
   k1 = k1 + 1;
   err = norm(r)/norm(g);
   Err1(k1) = err;
end


%«ейдель
B = triu(A);
invB = inv(B);

D = invB*A;
g = invB* f;
x = zeros(N, 1);
k2 = 0;
r = D*x - g;
err = norm(r)/norm(g);

while (err > eps && k2 < k_max)
   Ar = A*r;
   tau = (r'*r)/((Ar')*r);
   x = x - tau*r;
   r = D*x - g;
   k2 = k2 + 1;
   err = norm(r)/norm(g);
   Err2(k2) = err;
end

%SSR
C = diag(diag(A));
R = triu(A) - diag(diag(A));
w = 1.3;
B = C+w*R;
invB = inv(B);

D = invB*A;
g = invB* f;
x = zeros(N, 1);
k3 = 0;
r = D*x - g;
err = norm(r)/norm(g);

while (err > eps && k3 < k_max)
   Ar = A*r;
   tau = (r'*r)/((Ar')*r);
   x = x - tau*r;
   r = D*x - g;
   k3 = k3 + 1;
   err = norm(r)/norm(g);
   Err3(k3) = err;
end


%  якоби
B = diag(diag(A));
invB = inv(B);
[x, flag, relres, iter1, resvec1] = pcg(A,f, eps,10000);
[x, flag, relres, iter2, resvec2] = pcg(A,f, eps,10000,B);

semilogy(1:k1, Err1, 1:k2, Err2, 1:k3, Err3, 1:iter1+1, resvec1, 1:iter2+1, resvec2)
legend('Jacoby','Zeidel','SSR','pcg1','pcg2');
grid

condest(A/B)
