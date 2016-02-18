% Práctica 6

% Miguel Ascanio Gómez
% Carlos Ballesteros de Andrés

%% 1 Descripción de bordes

clear all; close all;

I = imread('Tema06a.bmp', 'bmp');
R = I (:,:,1);

[M,N] = size(R);

for i=1:M
    for j=1:N
        if (R(i,j) == 0)
                y(i,1) = 1;
                y(i,2) = j;
                b(i) = i;
        end
    end
end

a = pinv(y) * b';

x1 = 0;
x2 = N;
y1 = a(1) + a(2) * x1;
y2 = a(1) + a(2) * x2;

figure(); imshow(R); line([x1, x2], [y1, y2], 'LineWidth', 4);

% Se observa como el programa ajusta la línea curva de la imagen a la mejor
% recta que ha encontrado

%% 1B)
clear all; close all;

X = imread('lineas1.bmp','bmp');
detectar_lineas(X);

X = imread('lineas2.bmp','bmp');
detectar_lineas(X);

X = imread('lineas3.bmp','bmp');
detectar_lineas(X);

X = imread('lineas4.bmp','bmp');
detectar_lineas(X);

X = imread('Tema06b.bmp','bmp');
detectar_lineas(X);

% Se observa que los cuadrados azules caracterizan a las rectas: la
% posición en el eje y (ro) está relacionado por la posición de la recta;
% mientras que el valor del eje x determina el ángulo de la misma.


%% 2 Descripción de regiones

clear all; close all;

% 2A)

I = imread('Tema06c.bmp', 'bmp');
IR = I(:,:,1);

figure; imshow(IR); impixelinfo; title('Original');

% Binarizar
T = graythresh(IR);
A = IR < 255*T;

% N = número de etiquetas y valor de las Etiquetas de la imagen izquierda
[Etiquetas, N]=bwlabel(A,8);
figure; imshow(Etiquetas); impixelinfo; title('Etiquetas')

figure; imagesc(Etiquetas); colorbar

Prop =  regionprops(Etiquetas,'all');

for i=1:1:N
 disp(Prop(i));
end

% Se observa que el programa clasifica cada elemento con una etiqueta
% distinta, y que aporta una serie de propiedades para cada uno de ellos
% que lo definen.

%% 2B)

close all; clear all;

% primer 0
F0a = imread('Cero_a.bmp','bmp');
phi = invmoments(F0a);
%escalado
phi = abs(log10(abs(phi)));
disp('phi primer cero ='); disp(phi);

% segundo 0
F0b = imread('Cero_b.bmp','bmp');
phi = invmoments(F0b);
%escalado
phi = abs(log10(abs(phi)));
disp('phi segundo cero ='); disp(phi);

% tercer 0
F0c = imread('Cero_c.bmp','bmp');
phi = invmoments(F0c);
%escalado
phi = abs(log10(abs(phi)));
disp('phi tercer cero ='); disp(phi);

% cuarto 0
F0d = imread('Cero_d.bmp','bmp');
phi = invmoments(F0d);
%escalado
phi = abs(log10(abs(phi)));
disp('phi cuarto cero ='); disp(phi);


% primer 7
F7a = imread('Siete_a.bmp','bmp');
phi = invmoments(F7a);
%escalado
phi = abs(log10(abs(phi)));
disp('phi primer siete ='); disp(phi);

% segundo 7
F7b = imread('Siete_b.bmp','bmp');
phi = invmoments(F7b);
%escalado
phi = abs(log10(abs(phi)));
disp('phi segundo siete ='); disp(phi);

% tercer 7
F7c = imread('Siete_c.bmp','bmp');
phi = invmoments(F7c);
%escalado
phi = abs(log10(abs(phi)));
disp('phi tercer siete ='); disp(phi);

% cuarto 7
F7d = imread('Siete_d.bmp','bmp');
phi = invmoments(F7d);
%escalado
phi = abs(log10(abs(phi)));
disp('phi cuarto siete ='); disp(phi);

subplot(4,2,1); imshow(F0a)
subplot(4,2,2); imshow(F0b)
subplot(4,2,3); imshow(F0c)
subplot(4,2,4); imshow(F0d)
subplot(4,2,5); imshow(F7a)
subplot(4,2,6); imshow(F7b)
subplot(4,2,7); imshow(F7c)
subplot(4,2,8); imshow(F7d)

% Se observa que, para el mismo número, los valores de los invariantes de
% Hu varían levemente de una imagen a otra; siendo más distantes para
% números difrentes.
% Dentro del mismo número, rotar la imagen no provoca prácticamente ningún
% cambio (parejas 1y2,3y4 de cada número), mientras que al cambiar el
% tamaño (1y3) si se observan leves cambios.

%% 3 Opcionales

clear all; close all;

Demo1

% Se observa como, partiendo de un rectángulo rojo que no delimita nada, se
% va cerrando en torno a las células, hasta un momento que se forman dos
% zonas y no sólo una, cada una cerrándose poco a poco en torno a cada una
% de las células

%% 3B)
clear all; close all;

% lectura de las imágenes
%I1 = imread('Figura-09-15a.jpg','jpg');
%I2 = imread('Figura-09-16a.jpg','jpg');

I1 = imread('Tema06d1.bmp','bmp');
I2 = imread('Tema06d2.bmp','bmp');
I3 = imread('Tema06d3.bmp','bmp');

Ia1 = double(I1);
Ia2 = double(I2);
Ia3 = double(I3);

X1 = log(abs(fftshift(fft2(Ia1(:,:,1))))); 

X2 = log(abs(fftshift(fft2(Ia2(:,:,1))))); 

X3 = log(abs(fftshift(fft2(Ia3(:,:,1))))); 

figure;  imshow(I1);
figure;  imagesc(X1); colorbar;
figure;  imshow(I2);
figure;  imagesc(X2); colorbar;
figure;  imshow(I3);
figure;  imagesc(X3); colorbar;

% Se observan unas líneas perpendiculares a los lados de la figura. 
% La se gunda imagen al estar girada hace que rote también el espectro de
% frecuencias en el mismo angulo que la figura.
% En la imagen adicional, la del triángulo con la base de abajo a 0º, se
% observa en la transformada que no aparece ninguna paralela a la línea
% vertical: esto se debe a que la base de ese triángulo, al ser una línea
% horizontal, no contiene los "dientes de sierra", que hace aparecer un
% montón de líneas producidas por los píexeles de los dientes de sierra de
% los otros bordes.