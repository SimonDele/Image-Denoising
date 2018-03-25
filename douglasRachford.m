

img = imread('images/MarioStar.png');

[h,w ] = size(img);
%stripify img
img_striped = stripify(img, 0.2);
%change img to vector
f = reshape(img_striped,[h*w,1]);

%% Algorithme de douglas Rachford

% parameter
n_iter = 500;
lambda = 0.01;

%init
u = f;
s = zeros(size(f));

% loop
y = [double(u); double(s)];
for i=1:n_iter 
    if mod(i,10)==0
        disp(sprintf('%d / %d',i, n_iter));
    end
    x = prox_G2(h,w,y);
    y = y + lambda.*(prox_G1(h,w,2.*x-y,double(f))- x);
end


u = x(1:size(x,1)/2,:);
s = x(size(x,1)/2+1:end,:);

u = reshape(u, h, w);
s = reshape(s,h,w);


%Pour normaliser l'image :
%mini = min(min(u))
%u = (u - mini)/max(max(u));



imshow(u)
imshow(s)