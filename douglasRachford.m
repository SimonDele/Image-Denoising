close all;
clear all;
clc;

img = imread('images/MarioStar.png');

[h,w] = size(img);
%stripify img
img_striped = stripify(img, 0.2);
%change img to vector
f = double(reshape(img_striped,[h*w,1]))/256.;

%%Calcul des opérateurs gradient
I = speye(h);
D =  sparse(-diag(ones(w,1), 0) + diag(ones(w-1,1),1));
D(w,w) = 0;

nabla_x = sparse(kron(I,D));
nabla_y = sparse(kron(D,I));

%% Algorithme de douglas Rachford

% parameter
n_iter = 500;
lambda = 0.1;

%init
u = f;
s = zeros(size(f));
y1 = nabla_x*u;
y2 = zeros(size(f));

% loop
y = [u; s; y1; y2];
for i=1:n_iter 
    if mod(i,10)==0
        disp(sprintf('%d / %d',i, n_iter));
    end
    x = prox_G1(y,f,h,w, nabla_x, nabla_y);
    y = y + lambda*(prox_G2(h,w,2*x-y, nabla_x, nabla_y)- x);
end


u = x(1:h*w);
s = x(h*w+1:h*w*2);

u = reshape(u,h,w);
s = reshape(s,h,w);


%Pour normaliser l'image :
%mini = min(min(u));
%u = (u - mini)/max(max(u));

subplot(2,2,1);
title('Image stripée');
imshow(img_striped);

subplot(2,2,2);
imshow(u);
title('Image dé-stripée');

subplot(2,2,3);
imshow(s);
title('Stripes');