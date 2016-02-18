% Práctica 3

% Miguel Ascanio Gómez
% Carlos Ballesteros de Andrés

%% 1 Suavizado

clear all; close all;

% a)
Imagen  = imread('Tema04a.jpg','jpeg');

% Corrupción
ImagenRuido = mat2gray(imnoise(Imagen, 'gaussian', 0, 0.05));
ImagenRuidoR = ImagenRuido(:,:,1);

subplot(2,1,1); imshow(Imagen);  title('imagen original');
subplot(2,1,2); imshow(ImagenRuidoR); title('imagen ruidosa');

% b)
nucleo = (1/9)*[1 1 1; 1 1 1; 1 1 1];

% Imagen suavizada
ImagenSuavi = mat2gray(conv2(ImagenRuidoR,nucleo,'same'));

figure();

subplot(2,2,1); imshow(Imagen);  title('imagen original');
subplot(2,2,2); imshow(ImagenRuidoR); title('imagen ruidosa');
subplot(2,2,3); imshow(ImagenSuavi); title('imagen suavizada h = promedio');

%c)
sigma = 5;
size = 5;
nucleo = fspecial('gaussian', size, sigma);

% Imagen suavizada con h
ImagenSuavi = mat2gray(conv2(ImagenRuidoR, nucleo, 'same'));

figure();
subplot(2,2,1); imshow(Imagen);  title('imagen original');
subplot(2,2,2); imshow(ImagenRuidoR); title('imagen ruidosa');
subplot(2,2,3); imshow(ImagenSuavi); title('imagen suavizada gaussiana');

%% 2 Realzado
clear all; close all;

ImagenI = imread('Tema04b-lzda.jpg','jpeg');
ImagenD = imread('Tema04b-Dcha.jpg','jpeg');

Izda = ImagenI(:,:,1); Dcha = ImagenD(:,:,1);

subplot(2,2,1); imshow(Izda); title('Imagen Izda');
subplot(2,2,2); imshow(Dcha); title('Imagen Dcha');
subplot(2,2,3); imhist(Izda); title('Histograma Izda');
subplot(2,2,4); imhist(Dcha); title('Histograma Dcha');

% Ecualizacion de la imagen izquierda
EIzda = histeq(Izda);

figure;
subplot(2,2,1); imshow(Izda); title('Imagen Izda');
subplot(2,2,2); imshow(EIzda); title('Imagen Izda ecualizada');
subplot(2,2,3); imhist(Izda); title('Histograma imagen Izda');
subplot(2,2,4); imhist(EIzda); title('Histograma imagen Izda ecualizada');

% Expansón de la imagen Izda

figure();

subplot(2,2,1); imshow(Izda); title('Imagen oscurecida');
subplot(2,2,2); imhist(Izda); title('Histograma');

Imagen = double(Izda);

MIN_IN = min(min(Imagen)); MAX_IN = max(max(Imagen));
MIN_OUT = 0; MAX_OUT = 255;

Ri = ((Imagen - MIN_IN)./(MAX_IN-MIN_IN)).*((MAX_OUT-MIN_OUT)+MIN_OUT);

Ri = mat2gray(Ri);

subplot(2,2,3); imshow(Ri); title('Imagen histograma expandido');
subplot(2,2,4); imhist(Ri); title('Histograma');

%% 3 Filtrado Homomórfico
close all; clear all;

% lectura de la imagen original
II = imread('Tema04b-lzda.jpg','jpeg');

subplot(2,1,1); imshow(II); title('Imagen original');

Imagen = double(II(:,:,1));

t = size(Imagen);
M = t(1);
N = t(2);

%filtrado homomórfico

I1=log(Imagen+1);
I1_fft=fftshift(fft2(I1));

% diseño del núcleo del filtro paso bajo
R = 100; %radio

FiltroPB = ones(M,N);
for i=1:1:M
    for j=1:1:N
       d = sqrt((i-M/2)^2 + (j-N/2)^2);
       if d < R 
          FiltroPB(i,j) = 0; 
       end
    end
end
FiltroPA = 1 - FiltroPB;

I1_filtrada = I1_fft.*FiltroPA;
I1_restaurada=abs(ifft2(I1_filtrada));

I11_restaurada = exp(I1_restaurada)-1;
Im=mat2gray(I11_restaurada);

subplot(2,1,2); imshow(Im); title('Imagen tras el filtro homomórfico');

%% 4 Operaciones radiométricas
clear all; close all;

close all; clear all;

% lectura de la imagen original
II = imread('Tema04b-lzda.jpg','jpeg');

Imagen = double(II(:,:,1));

t = size(Imagen);
M = t(1);
N = t(2);

% exponente m
m1 = 1/2; % raíz cuadrada
m2 = 2;   % cuadrada

L = 255; %255 niveles de gris
for i=1:1:M
    for j=1:1:N
        Res1(i,j) = L^(1-m1)*Imagen(i,j)^m1;
        Res2(i,j) = L^(1-m2)*Imagen(i,j)^m2;
        Res3(i,j) = L*log(1+Imagen(i,j))/log(1+L);
    end
end
Im1 = mat2gray(Res1);
Im2 = mat2gray(Res2);
Im3 = mat2gray(Res3);

subplot(2,2,1); imshow(II);  title('imagen original');
subplot(2,2,2); imshow(Im1); title('raíz cuadrada');
subplot(2,2,3); imshow(Im2); title('cuadrada');
subplot(2,2,4); imshow(Im3); title('logarítmica');