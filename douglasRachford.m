

img = imread('images/MarioStar.png');

[h,w ] = size(img);
%stripify img
img_striped = stripify(img, 0.2);
%change img to vector
f = reshape(img_striped,[h*w,1]);

%%Calcul des opérateurs gradient
I = speye(w);
D =  sparse(-diag(ones(h,1), 0) + diag(ones(h-1,1),1));
D(h,h) = 0;

nabla_x = sparse(kron(I,D));
nabla_y = sparse(kron(D,I));

%% Algorithme de douglas Rachford

% parameter
n_iter = 500;
lambda = 0.01;

%init
u = f;
s = zeros(size(f));
y1 = zeros(size(f));
y2 =zeros(size(f));

% loop
y = [double(u); double(s); y1; y2];
for i=1:n_iter 
    if mod(i,10)==0
        disp(sprintf('%d / %d',i, n_iter));
    end
    x = prox_G2(h,w,y, nabla_x, nabla_y);
    y = y + lambda.*(prox_G1(2*x-y,double(f),h,w, nabla_x, nabla_y)- x);
end


u = y(1:h*w,:);
s = y(h*w+1:h*w*2,:);

u = reshape(u, h, w);
s = reshape(s,h,w);


%Pour normaliser l'image :
%mini = min(min(u));
%u = (u - mini)/max(max(u));

subplot(1,2,1);
imshow(img_striped);
subplot(1,2,2);
imshow(u);
subplot(2,2,2);
imshow(s);