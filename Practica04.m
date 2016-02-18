% PRÁCTICA 4

% Carlos Ballesteros de Andrés
% Miguel Ascanio Gómez

%% 1- Perfiles de intensidad

clear all; close all;

I_Dob = imread('Tema05a.jpg','jpeg');
imshow(I_Dob(:,:,1));

improfile 

% Al trazar una linea que cruce las ventanas del edeificio de en medio,
% se observa una gran diferencia cuando pasa por una ventana y cuando no:
% cuando pasa por la pared, que es blanca, el valor tiende a 250, mientras
% que cuando pasa por la ventana, es más oscuro y se acerca a 0; al pasar
% por los marcos de la ventana, sube entre 100-150.


%% 2- Extracción de bordes

% Inicializar imagen
clear all; close all;

A = imread('Tema05a.jpg','jpeg');
I_Dob = A(1:4:end,1:4:end,1);

imshow(I_Dob); title('Original');

T1 = 0.1; T2 = 0.20;

% Operador de Sobel
[Sobel_1, void, Sobel_H, Sobel_V] = edge(I_Dob,'sobel',T1);
Sobel_2 = edge(I_Dob,'sobel',T2);

figure; imshow(Sobel_1); title('Sobel T = 0.1');
figure; imshow(Sobel_2); title('Sobel T = 0.2');
figure; imshow(Sobel_V); title('Componentes Horizontales');
figure; imshow(Sobel_H); title('Componentes Verticales');

% Operador de Prewitt
Prewitt = edge(I_Dob,'prewitt',T1);

figure; imshow(Prewitt); title('Prewitt T = 0.1');

Prewitt = edge(I_Dob,'prewitt',T1*3);

figure; imshow(Prewitt); title('Prewitt T = 0.3');

Prewitt = edge(I_Dob,'prewitt',T1*5);

figure; imshow(Prewitt); title('Prewitt T = 0.5');

% Se observa que al aumentar el umbral, aparecen menos bordes, con 0,3 ya
% se eliminan bordes como los limites de los edificios; con 0,5 se elimina
% todo (no reconoce nada como borde)

% Operador de Roberts
Roberts = edge(I_Dob,'roberts',T1);

figure; imshow(Roberts); title('Roberts T = 0.1');

% Operador de Canny
sigma = 5;
Canny = edge(I_Dob,'canny',T1, T2, sigma);

figure; imshow(Canny); title('Cannny T1 = 0.1; T2 = 0.2; sigma = 5');

% Zerocrossings
zerocross = edge(I_Dob,'zerocross');
figure; imshow(zerocross); title('Zero-crossing');

% Laplaciana
sigma = 2;
T = 3;

LAP = edge(double(I_Dob),'log',T,sigma);
figure; imshow(LAP); title('Laplaciana de la Gaussiana');

% Representación del operador

rango = 10; 
step2D = 0.05;
step3D = 0.5;
%2D
x1 = -rango:step2D:rango;
a = (2-(x1.^2/sigma^2)) .* exp(-(x1.^2)/(2*sigma^2));

figure; plot(x1,a,'Linewidth',2); title('Representación operador laplaciana de la Gaussiana');
% 3D
[x,y] = meshgrid(-rango:step3D:rango, -rango:step3D:rango);
a = (2-((x.^2 + y.^2)/sigma^2)) .* exp( -(x.^2 + y.^2)/(2*sigma^2));

z = a / sum(sum(a));
figure; surfc(x,y,z); colormap hsv; title('Representación operador laplaciana de la Gaussiana');

% Habría que valorar que se entiende por mejores resultados: si es mu grave
% perder algún borde, si es muy importante eliminar el "ruido" (como los
% bordes del agua)... Como se ve en Sobel, con el umbral 0.1 se marcan
% todos los bordes bien definidos, aunque aparece algo de ruido qque a lo
% mejor es indeseable; con el umbral 0.2 el ruido practicamente desaparece,
% a costa de que algunos bordes queden abiertos, o no definidos del todo.
% Con roberts y prewitt pasa algo parecido con sobel en umbral 0.1:
% aparecen todos los borde, pero con alún "añadido". En cuanto a Canny, la
% imagen queda bastante deformada y no aporta mucho más que sobel a 0.2.
% Zerocrossing y la laplaciana de la gaussiana tienen resultados similares,
% teniendo el segundo un poco menos de ruido.
% En líneas generales, Sobel y la laplaciana tienen, a nuestro parecer, los
% mejores resultados.

%% Prácticas opcionales

clear all; close all;

A = imread('Tema05a.jpg','jpeg');
I_Dob = double(A(1:4:end,1:4:end,1));

[M,N] = size(I_Dob);

% Método de Sobel
T = 100; 

ImTrans = zeros(M,N);
Angulos = zeros(M,N);

% mascaras
gx = [ -1  0  1;
       -2  0  2; 
       -1  0  1 ]; 
gy = [ -1 -2 -1; 
        0  0  0; 
        1  2  1 ]; 

% Dimensión 2w+1
w = 1; %dimensión de la máscara 3x3
for i = 1+w:M-w
    for j = 1+w:N-w
      Ventana = I_Dob(i-w:1:i+w,j-w:1:j+w);  
      Ax = sum(sum(gx.*Ventana));
      Ay = sum(sum(gy.*Ventana));
      Angulos(i,j) = atan2(Ax,Ay);      
      A = abs(Ax) + abs(Ay);
      if A > T
         ImTrans(i,j) = 1;         
      end
    end
end


figure; imshow(mat2gray(ImTrans)); title('Bordes Sobel T = 100');
figure; imshow(mat2gray(Angulos)); title('Angulos Sobel');

% Laplaciana

Nucleo = [ -1 -1 -1 ;
           -1  8 -1 ; 
           -1 -1 -1 ];

L = conv2(I_Dob, Nucleo, 'same');

B = zeros(M,N);

T = 150;
for i = 2:M-1
    for j = 2:N-1
      if (((L(i,j) < -T) && (...
              (L(i-1,j-1) > T) || (L(i-1,j) > T) || ...
              (L(i-1,j+1) > T) || (L(i,j-1) > T) || (L(i,j+1) > T) || ...
              (L(i+1,j-1) > T) || (L(i+1,j) > T) || (L(i+1,j+1) > T))) ...
          || ((L(i,j) > T)  && (...
              (L(i-1,j-1) < -T) || (L(i-1,j) < -T) || (L(i-1,j+1) < -T) || ...
              (L(i,j-1) < -T)   || (L(i,j+1) < -T) || (L(i+1,j-1) < -T) || ...
              (L(i+1,j) < -T)   || (L(i+1,j+1) < -T))))
          B(i,j) = 255;
      end
    end
end

figure; imshow(B); title('Bordes Laplaciana T = 150');

% Harris

K = 200;
[H,B] = harris(I_Dob,K);

figure; imshow(mat2gray(H)); title('Puntos de interés');
figure; imshow(B); title('Localizaciones');

