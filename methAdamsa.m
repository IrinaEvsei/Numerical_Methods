clear;
clc;

lambda = -10;
f = @(t, u) lambda * u;
tochnoe = @(t) exp(lambda * t);

u0 = 1;
t0 = 0;
T = 10;
tau = 1.1 / abs(lambda);
t = t0:tau:T;
n = length(t);
y = zeros(0, n);

y(1) = u0;

k1 = tau * f(t(1), y(1));
k2 = tau * f(t(1) + tau, y(1) + k1);
y(2) = y(1) + (k1 + k2) / 2;

b2 = [3/2, -1/2];
for k=3:n
    y(k) = y(k - 1) + tau * lambda * (b2(1) * y(k - 1) + b2(2) * y(k - 2));
end

plot(t, y, '.-', t, tochnoe(t), 'o-')
legend('MOYE', 'TOCHNOe')

Err = abs(tochnoe(t) - y);

figure

plot(t, Err, '-')
