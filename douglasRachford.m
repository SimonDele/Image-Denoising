

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
y = f
for i=1:n_iter
    x = prox_G2(h,w,y);
    y = y + lambda*(prox_G1(2*x-y)- x);
end

% reshape(img_striped, w, h)