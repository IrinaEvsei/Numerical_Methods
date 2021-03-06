% ������� 1

%��� ������� ��� ������� gallery('lehmer',n).
%1.	��������� � ��������������� �������� ������ ����������� ����� ��������������� ������� �� �� 
%����������� (�� 20 �� 100).
%2.	������ ������� ��� ������� ������ (\) � � ������� LU ���������� � �������� ����������� �� 
%5 �� 20 � ������ ������ b0=rand(N,1) � ����������� �������� b1= b0*1.e-7.*rand(N,1). ��������� 
%� ��������������� �������� ����������� ������������� ����� ����������� �������   �� ����������� �������.
%�������� �������.
%3.	������ ������� ��� (� ���������  ) � ������ ������ b0=rand(N,1) ������� ����������� ���������� 
%(������������ ������� pcg) ��� �������������������, � ������������ �������������������� � �
%�������������������� �� ������� � ������ ����������� ������ ��� ����������� ������� �� 100 �� 1000 
%� ����� 100. ��������� ����������� ��������� ����������� ������� ������ 3-� ������� �� ����������� 
%�������. �������� �������. � ����� ���� figure ��������� ������ ����������� ����� �������� ��� 3-� �������
%�� ����������� �������. �������� �������.

%#1
%clear();
%for n=20:100
%    A = gallery("lehmer", n);
%    condA(n) = condest(A);
%end
%plot(1:100, condA)

%#2
%clear;

%X = [];
%normGauss =[];
%normLU=[];

%i=1;
%for n = 5:20
%    b0 = rand(n, 1);
%    b1 = b0*1e-7.*rand(n, 1);
%    A = gallery('lehmer', n);
%    X = A \ b0;
%    X1 = A \ b1;
%    normGauss(end + 1) = normest(X - X1) / normest(X);
    
%    [L, U, P] = lu(A);
%    y = L \ (P * b0);
%    x = U \ y;
    
%    [L, U, P] = lu(A);
%    y1 = L \ (P * b1);
%    x1 = U \ y1;
%    normLU(end + 1) = normest(x - x1) / normest(x);  
%end
%semilogy(5:20, normGauss, 5:20, normLU);
%legend('�����', 'LU-������������');%������� ���������


%#3
clear;
e = 10e-5;
withoutTime = [];
wVal = [];
diagTime = [];
dVal = [];
uplowTime = [];
ulVal = [];
for n = 100:100:1000
    m = n;
    A = gallery('lehmer', n);
    f=rand(m, 1);
    
    BDiag = diag(diag(A));
    
    R1 = tril(A);
    R2 = triu(A);
    for i=1:n
       R1(i, i) = R1(i, i) / 2;
       R2(i, i) = R2(i, i) / 2;
    end
    
    %��� �������������������
    tic
    [x1, flag1, relres1, iter1, value1] = pcg(A, f, e, 1000);
    withoutTime(end + 1) = toc;
    wVal(end + 1) = iter1;
    
    %� ������������ ��������������������
    tic
    [x2, flag2, relres2, iter2, value2] = pcg(A, f, e, 1000, BDiag);
    diagTime(end + 1) = toc;
    dVal(end + 1) = iter2;
    
    %�� ������� � ������ ����������� ������
    tic
    [x3, flag3, relres3, iter3, value3] = pcg(A, f, e, 1000, R1, R2);
    uplowTime(end + 1) = toc;
    ulVal(end + 1) = iter3;
end

subplot(2, 1, 1);
bar(100:100:1000, [withoutTime; diagTime; uplowTime]');
legend('��� �������������������', '� ������������ ��������������������', '�� ������� � ������ ����������� ������');
subplot(2, 1, 2);
plot(100:100:1000, wVal, 100:100:1000, dVal, 100:100:1000, ulVal);
legend('��� �������������������', '� ������������ ��������������������', '�� ������� � ������ ����������� ������');