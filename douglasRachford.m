

img = imread('images/MarioStar.png');

[h,w ] = size(img);
%stripify img
img_striped = stripify(img, 0.2);
%change img to vector
f = reshape(img_striped,[h*w,1]);

%% Algorithme de douglas Rachford

% parameter
n_iter = 1;
lambda = 0.01;

%init
u = f;
s = zeros(size(f));

% loop
for i=1:n_iter
    [xu,xs] = prox_G2(h,w,u,s);
    yu = yu + lambda*(prox_G1(2*xu-yu)- xu);
    ys = ys + lambda*(prox_G1(2*xs-ys)- xs);
end

% reshape(img_striped, w, h)