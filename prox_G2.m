function res = prox_G2 (h,w,z)
%w = 7;
%h=5;

%z=ones(w*h*2,1);

u = z(1:size(z,1)/2,:);
s = z(size(z,1)/2+1:end,:);


I = speye(w);
D = sparse(-diag(ones(h,1), 0) + diag(ones(h-1,1),1));
D(h,h) = 0;

nabla_x = sparse(kron(I,D));
nabla_y = sparse(kron(D,I));

%prox de indicatrice de C chapeau

res1 = (speye(w.*h) + nabla_x'*nabla_x)\(u + nabla_x'* u);
res2 = (speye(w*h) + nabla_y'*nabla_y)\(s + nabla_y'* s);

res = [res1;res2] ;

end