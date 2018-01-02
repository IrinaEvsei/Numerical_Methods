% subplot(1,4,1);
% spy(A);
% subplot(1,4,2);
% spy(L);
% subplot(1,4,3);
% spy(U);
% subplot(1,4,4);
% spy(P);
n=5;
% for i=1:n
%     for j=1:5
%         B(i,j)=100/(i+j-1);
%     end;
% end;
% f=zeros(n,1);
% for i=n:
%     f(i)=i+1/i;
% end;
% [L,U,P]=lu(B);

% f1=f*P;

% Y=[];
% for i=i:5
%     for j=1:5
%         Y(i,j)=f1(i)-L(i,j)*Y(i);
%     end;
% end;
Y(1)=f1(1);
Y(2)=f1(2)-L(2,1)*Y(1);
Y(3)=f1(3)-L(3,1)*Y(1)-L(3,2)*Y(2);
Y(4)=f1(4)-L(4,1)*Y(1)-L(4,2)*Y(2)-L(4,3)*Y(3);
Y(5)=f1(5)-L(5,1)*Y(1)-L(5,2)*Y(2)-L(5,3)*Y(3)-L(5,4)*Y(4);