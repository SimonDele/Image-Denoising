function res = prox_G1 (w,h,z,f)

%parameters : 
mu_2 = 1;
mu_1 = 1;

u = z(1:size(z,1)/2,:);
s = z(size(z,1)/2+1:end,:);

I = speye(w);
D =  sparse(-diag(ones(h,1), 0) + diag(ones(h-1,1),1));
D(h,h) = 0;

nabla_x = sparse(kron(I,D));
nabla_y = sparse(kron(D,I));


% prox d'indicatrice de C
u = min(max(0,(u+f-s)./2),1);
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

res = [prox_y1;prox_y2];

end