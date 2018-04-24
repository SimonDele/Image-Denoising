function res = prox_G1 (z,f,h,w, nabla_x, nabla_y)

%parameters : 
mu_2 = 10;
mu_1 = 1;

u = z(1:h*w,:);
s = z(h*w+1:2*h*w,:);
y1 = z(2*h*w+1:3*h*w,:);
y2 = z(3*h*w+1:end,:);

%% prox d'indicatrice de C
u = min(max(0,(u+f-s)./2),1);
s = f - u;
prox_ic = [u ; s];

%% prox de h

%y1 = nabla_x*u;
%y2 = nabla_y*s;

if (norm(y1,1) > mu_1)
    prox_y1 = y1 - mu_1 * y1 ./ norm(y1,1);
else
    prox_y1 = zeros(h*w,1);
end

if (norm(y2,1) > mu_2)
    prox_y2 = y2 - mu_2*y2 ./ norm(y2,1);
else
    prox_y2 = zeros(h*w,1);
end

res = [prox_ic;prox_y1;prox_y2];

end