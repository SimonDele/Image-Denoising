function res = prox_G2 (h,w,z)

%w = 7;
%h = 5;



u = z(1:size(z,1)/2,:);
s = z(size(z,1)/2+1,:);


I = diag(ones(w,1),0);
D =  -diag(ones(h,1), 0) + diag(ones(h-1,1),1);
D(h,h) = 0;

nabla_x = kron(I,D);
nabla_y = kron(D,I);

%prox de indicatrice de C chapeau
res1 = (diag(ones(w*h,1),0) + nabla_x'*nabla_x)\(u + nabla_x'* u);
res2 = (diag(ones(w*h,1),0) + nabla_y'*nabla_y)\(s + nabla_y'* s);

res = [res1,res2] ;

end