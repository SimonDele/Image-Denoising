function res = prox_G1 (w,h,u,s,f)

%parameters : 
mu_2 = 1;

I = diag(ones(w,1),0);
D =  -diag(ones(h,1), 0) + diag(ones(h-1,1),1);
D(h,h) = 0;

nabla_x = kron(I,D);
nabla_y = kron(D,I);


% prox d'indicatrice de C
u = min(max(0,(u+f-s)/2),1);
s = f - u;

% prox de h

y1 = nabla_x*u;
y2 = nabla_y*s;

if (norm(y1) > mu_1)
    prox_y1 = y1 - mu_1 * y1 ./ norm(y1,1);
else
    prox_y1 = zeros(h*w);
end

if (norm(y2) > 1)
    prox_y2 = y2 - y2 ./ norm(y2,1);
else
    prox_y1 = zeros(h*w);
end

res = prox_y1 + prox_y2;

end