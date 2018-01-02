syms t
eps=1e-11;
x1=-0.5;
x2=3.5;
x0=1.5;
x=x1:0.1:x2;
func=@(t) t.^3-6*t.^2+9*t; %анон функция
tow=0.04; %<1
fi=@(t) t+tow*func(t);

%plot(t, t, t, fi(t))

xarray=[];
b=1.6;
i1=0;
%прост итер
while (abs(func(b)) > eps)
    b=fi(b);
    xarray(end+1)=b;
    i1=i1+1;
end


dif=diff(func,t);
tow2=@(t) -1/eval(dif);

xarray2=[];
b2=1.6;
i2=0;
fi2=@(t) t+tow2(t)*func(t);
%ньютона
while (abs(func(b2)) > eps)
    b2=fi2(b2);
    xarray2(end+1)=b2;
    i2=i2+1;
end

%plot(func(xarray));
%figure 
%plot(func(xarray2));

semilogy(1:i1,func(xarray),1:i2,func(xarray2))



