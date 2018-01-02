% y = [];
% y1 = [];
% A=gallery('poisson',5);
%  N = 25;
%   f =rand(N,1);
%   f2 = rand(N,1);
%   mx = max(eig(A));
%   mn = min(eig(A));
%   x = zeros(N,1);
%   eps = 10^(-5);
%   r = A*x - f;
% r2 = A*x - f2;
%   fnorm = norm(f);
% fnorm2 = norm(f2);
%   iter = 0;
% iter2 = 0;
%   val = [];
%   val2= [];
%  while (norm(r)/fnorm > eps & iter < 1000)
%       r =A*x -f ;
%       ar = A*r;
%       x = x - ((ar' * r)/(ar' * ar))*r;
%       iter = iter + 1;
%       val (iter) = norm(r)/fnorm;
%  end
% x = zeros(N,1);
%   while (norm(r2)/fnorm2> eps & iter2 < 1000) 
% r2=A*x -f2; 
% tow = (r2'*r2)/((A*r2)'*r2);
% x = x - tow*r2; 
% iter2 = iter2 + 1; 
% val2 (iter2) = norm(r2/fnorm2); 
%   end
% semilogy(1:iter, val,1:iter2, val2)
%  legend('Minimalnih nevyazok', 'Naiskoreyshego spuska')

A=gallery('poisson',5);
N = 25;
f =rand(N,1);
f2 =rand(N,1);
fnorm = norm(f);
fnorm2 = norm(f2);
iter = 0;
iter2 = 0;
iter3 = 0;
x = zeros(N,1);
r = A*x - f;
 r2 = A*x - f2;
sigma0 = (r' * r);
tow = sigma0/((A*r)'*r);
x = x - tow * r;
d = r;
eps = 10^(-5);
val = [];
val2 = [];

 while (norm(r)/fnorm > eps & iter < 1000)
      r =A*x -f ;
      sigma = (r' * r);
      beta = sigma/sigma0;
      d = r + beta*d;
      tow = sigma/(d' * (A*d));
      x = x - tow*d;
      iter = iter + 1;
      val (iter) = norm(r)/fnorm;
      sigma0 = sigma;
 end
 x = zeros(N,1);
  while (norm(r2)/fnorm2> eps & iter2 < 1000) 
r2=A*x -f2; 
tow = (r2'*r2)/((A*r2)'*r2);
x = x - tow*r2; 
iter2 = iter2 + 1; 
val2 (iter2) = norm(r2/fnorm2); 
  end
[x,flag,relres,iter3,resvec] = pcg(A,f,eps);
semilogy(1:iter, val,1:iter2, val2, 1:iter3+1, resvec)
























