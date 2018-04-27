function res = prox_G2 (h,w,z, nabla_x, nabla_y)


u = z(1:h*w,:);
s = z(h*w+1:2*h*w,:);
y1 = z(2*h*w+1:3*h*w,:);
y2 = z(3*h*w+1:end,:);


%% prox de indicatrice de C chapeau
u_chap = (speye(w*h) + nabla_x'*nabla_x)\(u + nabla_x'* y1);
y1_chap = nabla_x*u_chap;

%% prox de indicatrice de C tilde
s_tilde = (speye(w*h) + nabla_y'*nabla_y)\(s + nabla_y'* y2);
y2_tilde = nabla_y*s_tilde;

res = [u_chap;s_tilde;y1_chap;y2_tilde] ;

end