clear;
clc;

% Carregar a imagem (Cristo no Templo (1897) - Heinrich Hofmann - 50x68)
RGB = imread('images.jpg');

% Converter a imagem em escala
A =  mat2gray(RGB);  
A = rgb2gray(A); 

% Redimensionar imagem

m = input('Nova altura da imagem: ');
n = input('Nova largura da imagem: ');

if m>n
    f=n;
else
    f=m;
end

A = imresize(A,[m n]); 

% perform svd on A
[U, S, V] = svd(A);

% Take singular values
sv = diag(S);

% Qualidade da imagem
fprintf('Qualidade da imagem k (de 1 até %d): \n',f);
k = input('k= '); 
Ak = U(:,1:k)*S(1:k,1:k)*V(:,1:k)'; 

imagesc(Ak); colormap gray; axis image;
figure(2)
plot(sv),title('Singular Values of the Image'),xlabel('Index'),ylabel('Singular Value')