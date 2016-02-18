% Practica 2

% Miguel Ascanio Gómez
% Carlos Ballesteros de Andrés

%% Parte 1

clear all; close all;
figure();

% Rojo
rojo(1:9, 1:9, 1) = 255;
rojo(1:9, 1:9, 2) = 0;
rojo(1:9, 1:9, 3) = 0;

rojo = mat2gray(rojo, [0,255]);

subplot(3,3,1);
imshow(rojo);

% Verde
verde(1:9, 1:9, 1) = 0;
verde(1:9, 1:9, 2) = 255;
verde(1:9, 1:9, 3) = 0;

verde = mat2gray(verde, [0,255]);

subplot(3,3,2);
imshow(verde);

% Azul
azul(1:9, 1:9, 1) = 0;
azul(1:9, 1:9, 2) = 0;
azul(1:9, 1:9, 3) = 255;

azul = mat2gray(azul, [0,255]);

subplot(3,3,3);
imshow(azul);

% Amarillo
amarillo(1:9, 1:9, 1) = 255;
amarillo(1:9, 1:9, 2) = 255;
amarillo(1:9, 1:9, 3) = 0;

amarillo = mat2gray(amarillo, [0,255]);

subplot(3,3,4);
imshow(amarillo);

% Magenta
magenta(1:9, 1:9, 1) = 255;
magenta(1:9, 1:9, 2) = 0;
magenta(1:9, 1:9, 3) = 255;

magenta = mat2gray(magenta, [0,255]);

subplot(3,3,5);
imshow(magenta);

% Cyan
cyan(1:9, 1:9, 1) = 0;
cyan(1:9, 1:9, 2) = 255;
cyan(1:9, 1:9, 3) = 255;

cyan = mat2gray(cyan, [0,255]);

subplot(3,3,6);
imshow(cyan);

% Gris
gris(1:9, 1:9, 1) = 128;
gris(1:9, 1:9, 2) = 128;
gris(1:9, 1:9, 3) = 128;

gris = mat2gray(gris, [0,255]);

subplot(3,3,7);
imshow(gris);


% Blanco
blanco(1:9, 1:9, 1) = 255;
blanco(1:9, 1:9, 2) = 255;
blanco(1:9, 1:9, 3) = 255;

blanco = mat2gray(blanco, [0,255]);

subplot(3,3,8);
imshow(blanco);

% Negro
negro(1:9, 1:9, 1) = 0;
negro(1:9, 1:9, 2) = 0;
negro(1:9, 1:9, 3) = 0;
subplot(3,3,9);
imshow(negro);


%% Parte 2

clear all; close all;

Original = imread('Tema03b.jpg','jpg');

% Reducción de dimensionalidad
Original = Original(1:4:end,1:4:end,:);

% Componentes
Rojo = Original(:,:,1); Verde = Original(:,:,2); Azul = Original(:,:,3); 

subplot(2,2,1); imshow(Original); title('Original');

subplot(2,2,2); imshow(Rojo);     title('Canal Rojo');
subplot(2,2,3); imshow(Verde);    title('Canal Verde');
subplot(2,2,4); imshow(Azul);     title('Canal Azul');

% Componentes de color CMY

figure();

subplot(2,3,1); imshow(Original);     title('Original');

subplot(2,3,2); imshow(255-Rojo);     title('Cyan');
subplot(2,3,3); imshow(255-Verde);    title('Magenta');
subplot(2,3,4); imshow(255-Azul);     title('Amarillo');

CMY(:,:,1) =  255-Rojo;  CMY(:,:,2) =  255-Verde;  CMY(:,:,3) =  255-Azul;
subplot(2,3,5) ; imshow(CMY); title('CMY');

% componentes de color YIQ

R = Original(:,:,1); G = Original(:,:,2); B = Original(:,:,3); 

T = [0.299 0.587 0.114; 0.596 -0.275 -0.321; 0.212 -0.523 0.311];

[M,N,s] = size(Original);

for i=1:1:M
    for j=1:1:N
      YIQ(i,j,1) = T(1,1)*R(i,j)+T(1,2)*G(i,j)+T(1,3)*B(i,j); 
      YIQ(i,j,2) = T(2,1)*R(i,j)+T(2,2)*G(i,j)+T(2,3)*B(i,j); 
      YIQ(i,j,3) = T(3,1)*R(i,j)+T(3,2)*G(i,j)+T(3,3)*B(i,j); 
    end
end

figure();    
subplot(2,3,1); imshow(Original); title('Original');

subplot(2,3,2); imshow(YIQ(:,:,1));     title('Y');
subplot(2,3,3); imshow(YIQ(:,:,2));     title('I');
subplot(2,3,4); imshow(YIQ(:,:,3));     title('Q');

subplot(2,3,5) ; imshow(YIQ); title('YIQ');

% componentes HSI

HSI = rgb2hsv(Original);
   
figure(); 
subplot(2,3,1); imshow(Original); title('Original');

subplot(2,3,2); imshow(HSI(:,:,1));     title('H');
subplot(2,3,3); imshow(HSI(:,:,2));     title('S');
subplot(2,3,4); imshow(HSI(:,:,3));     title('I');

subplot(2,3,5) ; imshow(HSI); title('HSI');

% reconstrucción

RGB = hsv2rgb(HSI);
subplot(2,3,6) ; imshow(RGB); title('RGB reconstruida');

%% Parte 3 - Operaciones elementales píxel a píxel

close all; clear all;

Imagen = imread('Tema03b.jpg','jpg');
Imagen = Imagen(1:4:end,1:4:end,1);
[M,N,s] = size(Imagen);

figure(); imshow(Imagen);
title('Imagen original');

% 1) inversa
I1 = 255-Imagen;
figure(); imshow(I1); title('Imagen inversa');

% 2) umbral
p1 = 90;
ITrans(1:M, 1:N) = 255;
ITrans(Imagen < p1) = 0;

figure(); imshow(ITrans); title('Operador umbral');

% 3) operador intervalo de umbral binario
p1 = 50; p2 = 150; 

ITrans = zeros(M, N);
ITrans(Imagen < p1 | Imagen > p2) = 255;

figure(); imshow(ITrans); title('Operador intervalo umbral binario');

% 4) operador intervalo de umbral binario invertido
p1 = 50; p2 = 150; 

ITrans(1:M, 1:N) = 255;
ITrans(Imagen < p1 | Imagen > p2) = 0;

figure(); imshow(ITrans); title('Operador intervalo umbral binario invertido');

% 5) operador umbral escala de grises
p1 = 50; p2 = 150; 
ITrans = Imagen;
ITrans(Imagen < p1 | Imagen > p2) = 255;

figure(); imshow(ITrans); title('Operador umbral escala de grises');

% 6) operador umbral escala de grises invertido
p1 = 50; p2 = 150; 
ITrans = 255-Imagen;
ITrans(Imagen < p1 | Imagen > p2) = 255;

figure(); imshow(ITrans); title('Operador umbral escala de grises invertido');


% 7) operador extensión
p1 = 50; p2 = 150; 
ITrans = (Imagen-p1)*(255/(p2-p1));
ITrans(Imagen < p1 | Imagen > p2) = 0;

figure(); imshow(ITrans); title('Operador extensión');

%% Parte 4

close all; clear all;

Imagen = imread('Tema03c.jpg','jpg');
figure(); imshow(Imagen); title('Imagen original');
[M,N,s] = size(Imagen);

Imagen = Imagen(:,:,1);

nucleo = [ 1  2  1; 
           0  0  0; 
          -1 -2 -1];

I = conv2(double(Imagen),nucleo,'same');
figure(); imshow(I); title('Operador de vecindad 1');

nucleo = [ 1   2    1; 
           0   1.2  0; 
          -1  -2   -1];

I = mat2gray(conv2(double(Imagen),nucleo,'same'));
figure(); imshow(I); title('Operador de vecindad 2');

