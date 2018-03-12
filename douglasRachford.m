%Algorithme de douglas Rachford

n_iter = 100;
lambda = 0.01;

for i=1:n_iter
    xn = prox_G2(yn)
    yn = yn + lambda*(prox_G1(2*xn-yn)- xn)
end

