
f=imread('radiograph1.jpg'); % se carga la imagen a la que le haremos una convolución (distorsión)

imshow(f) % se muestra la imagen.


%% 
f=f(:,:,1);
imshow(f); 

%%
f = double(f)/255 ; % números reales 
imshow(f, []); %con los corchetes nuestro máximo se vuelve 1 y visualizamos la imagen

%% 
% con esto hacemos varias secciones donde podremos ir colocando nuestros resultados (1/4)
f=imresize(f,0.25);

figure(1);
subplot(2,2,1);
imshow(f,[]);
subplot(2,2,2);
mesh(f); % 

%%
% 1 está adentro, 0 está afuera

% h = 10*fspecial('disk', 10); % hace borrosa la imagen 
h = fspecial('gaussian',7,2); 

subplot(2,2,3);
% imshow(h, [])
mesh(h);

sum(sum(h)) % tiene que ser igual a 1
g = conv2(f, h, "same"); 

subplot(2,2,4);
imshow(g, []); %así captura equipo PET. 
%mesh(g);

% psf -> depende del fenomeno fisico de la luz y distancia ej. sombra.

%%
F=fft2(f,sz(1),sz(2));

subplot(2,2,4);
imshow(fftshift(log(abs(F))), []); % puntos y líneas


%%
sz = size(f);

f = zeros(sz(1));
f(int16(sz(1)/2), int16(sz(2)/2)) = 1;
f(int16(sz(1)/3), int16(sz(2)/2)) = 1;
f(int16(sz(1)/2), int16(sz(2)/3)) = 1;
subplot(2,2,2);
imshow(f, []);

h = fspecial('gaussian',7,2);
subplot(2,2,3);
mesh(h)

g = conv2(f,h,"same");% salida psf (función de distorsión)
subplot(2,2,4);
imshow(g, []);
mesh(g)

%%
for (x = 1:sz(1))
    for (y = 1:sz(2))
        f(y,x) = sin(y*0.7)*sin(x*0.5);
    end 
end 

subplot(2,2,1);
imshow(f, []);

%%
F=fft2(f,sz(1),sz(2));

subplot(2,2,2);
imshow(fftshift(log(abs(F))), []); % puntos y líneas
subplot(2,2,3);
imshow(fftshift(abs(F)), []); % solo se ven los puntos (se pueden modificar a lo que deseemos)

%Fourier frecuencias positivas o negativas
%%

f=imread('radiograph1.jpg'); 
imshow(f) % se muestra la imagen. 
f=f(:,:,1);
imshow(f); 

f = double(f)/255 ; % números reales 
imshow(f, []); %con los corchetes nuestro máximo se vuelve 1 y visualizamos la imagen
f=imresize(f,0.25);

h=fspecial('disk',10);
H=fft2(h,sz(1),sz(2));
G=F.*H;
g=abs(ifft2(G));

subplot(2,2,2);
imshow(g,[]);

G=F.*abs(H);
g=abs(ifft2(G));
subplot(2,2,3);
imshow(g,[]);
g2 = conv2(f,h,'same');

subplot(2,2,4);
imshow(g2,[]);
