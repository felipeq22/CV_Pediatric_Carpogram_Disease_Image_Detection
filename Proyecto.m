%Proyecto
clc
clear all
close all
%imagenes se llama el archivo donde estan las imagenes
currentfile = pwd;
currentfile = fullfile(currentfile,'imagenes');
Imagenes = dir(currentfile);

Anotaciones = xlsread('train.csv');
%Se pasan los meses a anios de las Anotaciones.
Anotaciones(:,2) = Anotaciones(:,2)./12;
DistribucionDatos = hist(Anotaciones(:,2),19);% Se realiza para ver los Histogramas de los datos.
figure; bar(DistribucionDatos);title('Distribucion Edad imagenes Totalmente');
xlabel('Edad en años');
ylabel('Cantidad de imagénes');

%Se divide en hombres y mujeres
TamanoAnotaciones = length(Anotaciones);

% ImagenesHombres = ();
% ImagenesMujeres = ();
CounterHombres = 1;
CounterMujeres =1;

for i = 1:TamanoAnotaciones
    ID = Anotaciones(i,1);
    Edad =Anotaciones(i,2);
    if Anotaciones(i,3) ==0 %Mujer
        
        ImagenesMujeres(CounterMujeres,1) = ID;
        ImagenesMujeres(CounterMujeres,2) = Edad;
        
        CounterMujeres = CounterMujeres+1;
    else
        ImagenesHombres(CounterHombres,1) = ID;
        ImagenesHombres(CounterHombres,2) = Edad;
        
        CounterHombres = CounterHombres +1;
    end
end
AnotacionesMujeres = ImagenesMujeres;
AnotacionesHombres = ImagenesHombres;

% Para dividir los datos de entrenamiento y de validacion
CounterMayor = 1;
CounterMenor = 1;

CounterMayorF = 1;
CounterMenorF= 1;

CounterMayorM = 1;
CounterMenorM= 1;
%Mitad de las edades.Hombre
Umbral = max(Anotaciones(:,2))/2;
UmbralMujeres = max(AnotacionesMujeres(:,2))/2;
UmbralHombres = max(AnotacionesHombres(:,2))/2;

% PARA MUJERES
% Para dividir las imagenes en edades
for i = 1:length(Anotaciones)
    %Se evalúa la edad de la imagen con respecto a las anotaciones.
   Value = Anotaciones(i,2); 
   if Value >= Umbral
      AnotacionesMayor(CounterMayor,1) =  Anotaciones(i,1);% Se anota el ID 
      %de la imagen.
      % Anotacion de la edad
      AnotacionesMayor(CounterMayor,2) = Value;
      
      CounterMayor = CounterMayor +1;
   else
      AnotacionesMenor(CounterMenor,1) =  Anotaciones(i,1);
      AnotacionesMenor(CounterMenor,2) = Value;       
      
      CounterMenor = CounterMenor +1;
   end
end

for i = 1:length(AnotacionesMujeres)
    %Se evalúa la edad de la imagen con respecto a las anotaciones.
   Value = AnotacionesMujeres(i,2); 
   if Value >= UmbralMujeres
      AnotacionesMayorMujeres(CounterMayorF,1) =  AnotacionesMujeres(i,1);% Se anota el ID 
      %de la imagen.
      % Anotacion de la edad
      AnotacionesMayorMujeres(CounterMayorF,2) = Value;
      
      CounterMayorF = CounterMayorF +1;
   else
      AnotacionesMenorMujeres(CounterMenorF,1) =  AnotacionesMujeres(i,1);
      AnotacionesMenorMujeres(CounterMenorF,2) = Value;       
      
      CounterMenorF = CounterMenorF +1;
   end
end

for i = 1:length(AnotacionesHombres)
    %Se evalúa la edad de la imagen con respecto a las anotaciones.
   Value = AnotacionesHombres(i,2); 
   if Value >= UmbralHombres
      AnotacionesMayorHombres(CounterMayorM,1) =  AnotacionesHombres(i,1);% Se anota el ID 
      %de la imagen.
      % Anotacion de la edad
      AnotacionesMayorHombres(CounterMayorM,2) = Value;
      
      CounterMayorM = CounterMayorM +1;
   else
      AnotacionesMenorHombres(CounterMenorM,1) =  AnotacionesHombres(i,1);
      AnotacionesMenorHombres(CounterMenorM,2) = Value;       
      
      CounterMenorM = CounterMenorM +1;
   end
end
% En el vector de anotaciones 1 hace referencia al ID y 2 hace referencia
% a la edad
CounterTrain = 1;
CounterVal = 1;
CounterTrainF = 1;
CounterValF = 1;
CounterTrainM = 1;
CounterValM = 1;

for i = 1:length(AnotacionesMenor)
    % Se asignan las imagenes pares a las de entrenamiento
    if mod(i,2) == 0
        ImagenesTrain(CounterTrain,1) = AnotacionesMenor(i,1);
        ImagenesTrain(CounterTrain,2) = AnotacionesMenor(i,2);
        CounterTrain = CounterTrain +1;
    else
        % Se asignan las iamgenes impares a las de entrenamiento.
        ImagenesVal(CounterVal,1) = AnotacionesMenor(i,1);
        ImagenesVal(CounterVal,2) = AnotacionesMenor(i,2);
        CounterVal = CounterVal +1;
    end
end

for i = 1:length(AnotacionesMenorMujeres)
    % Se asignan las imagenes pares a las de entrenamiento
    if mod(i,2) == 0
        ImagenesTrainMujeres(CounterTrainF,1) = AnotacionesMenorMujeres(i,1);
        ImagenesTrainMujeres(CounterTrainF,2) = AnotacionesMenorMujeres(i,2);
        CounterTrainF = CounterTrainF +1;
    else
        % Se asignan las iamgenes impares a las de entrenamiento.
        ImagenesValMujeres(CounterValF,1) = AnotacionesMenorMujeres(i,1);
        ImagenesValMujeres(CounterValF,2) = AnotacionesMenorMujeres(i,2);
        CounterValF = CounterValF +1;
    end
end
for i = 1:length(AnotacionesMenorHombres)
    % Se asignan las imagenes pares a las de entrenamiento
    if mod(i,2) == 0
        ImagenesTrainHombres(CounterTrainM,1) = AnotacionesMenorHombres(i,1);
        ImagenesTrainHombres(CounterTrainM,2) = AnotacionesMenorHombres(i,2);
        CounterTrainM = CounterTrainM +1;
    else
        % Se asignan las iamgenes impares a las de entrenamiento.
        ImagenesValHombres(CounterValM,1) = AnotacionesMenorHombres(i,1);
        ImagenesValHombres(CounterValM,2) = AnotacionesMenorHombres(i,2);
        CounterValM = CounterValM +1;
    end
end

% Ciclo para organizar las imagenes
for i = 1:length(AnotacionesMayor)
    if mod(i,2) == 0
        ImagenesVal(CounterVal,1) = AnotacionesMayor(i,1);
        ImagenesVal(CounterVal,2) = AnotacionesMayor(i,2);
        CounterVal = CounterVal +1;
    else
        ImagenesTrain(CounterTrain,1) = AnotacionesMayor(i,1);
        ImagenesTrain(CounterTrain,2) = AnotacionesMayor(i,2);
        CounterTrain = CounterTrain +1;
    end
end

for i = 1:length(AnotacionesMayorMujeres)
    if mod(i,2) == 0
        ImagenesValMujeres(CounterValF,1) = AnotacionesMayorMujeres(i,1);
        ImagenesValMujeres(CounterValF,2) = AnotacionesMayorMujeres(i,2);
        CounterValF = CounterValF +1;
    else
        ImagenesTrainMujeres(CounterTrainF,1) = AnotacionesMayorMujeres(i,1);
        ImagenesTrainMujeres(CounterTrainF,2) = AnotacionesMayorMujeres(i,2);
        CounterTrainF = CounterTrainF +1;
    end
end
for i = 1:length(AnotacionesMayorHombres)
    if mod(i,2) == 0
        ImagenesValHombres(CounterValM,1) = AnotacionesMayorHombres(i,1);
        ImagenesValHombres(CounterValM,2) = AnotacionesMayorHombres(i,2);
        CounterValM = CounterValM +1;
    else
        ImagenesTrainHombres(CounterTrainM,1) = AnotacionesMayorHombres(i,1);
        ImagenesTrainHombres(CounterTrainM,2) = AnotacionesMayorHombres(i,2);
        CounterTrainM = CounterTrainM +1;
    end
end
% %  DistribucionDatosValidacion = hist(ImagenesVal(:,2),19);
% % figure; bar(DistribucionDatosValidacion);title('Distribucion Edad imagenes Validacion');
% % xlabel('Edad en años');
% % ylabel('Cantidad de imagénes');
% % 
% %  DistribucionDatosTrain = hist(ImagenesTrain(:,2),19);
% % figure; bar(DistribucionDatosTrain);title('Distribucion Edad imagenes Train');
% % xlabel('Edad en años');
% % ylabel('Cantidad de imagénes');
% % 
% % DistribucionDatosValidacionMujeres = hist(ImagenesValMujeres(:,2),19);
% % figure; bar(DistribucionDatosValidacionMujeres);title('Distribucion Edad imagenes Mujeres Validacion');
% % xlabel('Edad en años');
% % ylabel('Cantidad de imagénes');

DistribucionDatosTrainMujeres = hist(ImagenesTrainMujeres(:,2),19);
figure; bar(DistribucionDatosTrainMujeres);title('Distribucion Edad imagenes mujeres Train');
xlabel('Edad en años');
ylabel('Cantidad de imagénes');

DistribucionDatosValidacionHombres = hist(ImagenesValHombres(:,2),19);
figure; bar(DistribucionDatosValidacionHombres);title('Distribucion Edad Hombres imagenes Validacion');
xlabel('Edad en años');
ylabel('Cantidad de imagénes');

 DistribucionDatosTrainHombres = hist(ImagenesTrainHombres(:,2),19);
figure; bar(DistribucionDatosTrainHombres);title('Distribucion Edad Hombres imagenes Train');
xlabel('Edad en años');
ylabel('Cantidad de imagénes');

%Ciclo para pasar las imagenes a su nombre para poder leerlas despues
% TamanoTrain = length(ImagenesTrain);
% TamanoVal = length(ImagenesVal);
% 
% TamanoTrainF = length(ImagenesTrainMujeres);
% TamanoValF = length(ImagenesValMujeres);
% 
% TamanoTrainM = length(ImagenesTrainHombres);
% TamanoValM = length(ImagenesValHombres);
%QUITAR COMENTARIO CUANDO SE CORRA EN EL PC UNIVERSIDAD.

TamanoTrainF = 300;
TamanoValF = 300;
TamanoTrainM = 300;
TamanoValM = 300;

j = 1377;
for i = 1:TamanoTrainF
    if i<150
    Id =num2str(ImagenesTrainMujeres(i,1));
    Anota =num2str(ImagenesTrainMujeres(i,2));
    url = [Id,'.png'];
    ImagesTrainMujeres{i,1} = imread(url);
    ImagesTrainMujeres{i,2} = [Anota];
    else
    Id =num2str(ImagenesTrainMujeres(j,1));
    Anota =num2str(ImagenesTrainMujeres(j,2));
    url = [Id,'.png'];
    ImagesTrainMujeres{i,1} = imread(url);
    ImagesTrainMujeres{i,2} = [Anota];
    j = j +1;
    end
end
j = 1183;
for i = 1:TamanoValF
    if i<150
    Id =num2str(ImagenesValMujeres(i,1));
    Anota =num2str(ImagenesValMujeres(i,2));
    url = [Id,'.png'];
    ImagesValMujeres{i,1} = imread(url);
    ImagesValMujeres{i,2} = [Anota];
        else
    Id =num2str(ImagenesValMujeres(j,1));
    Anota =num2str(ImagenesValMujeres(j,2));
    url = [Id,'.png'];
    ImagesValMujeres{i,1} = imread(url);
    ImagesValMujeres{i,2} = [Anota];
    j = j +1;
    end
end

j = 1380;
for i = 1:TamanoTrainM
    if i<150
    Id =num2str(ImagenesTrainHombres(i,1));
    Anota =num2str(ImagenesTrainHombres(i,2));
    url = [Id,'.png'];
    ImagesTrainHombres{i,1} = imread(url);
    ImagesTrainHombres{i,2} = [Anota];
    else
    Id =num2str(ImagenesTrainHombres(j,1));
    Anota =num2str(ImagenesTrainHombres(j,2));
    url = [Id,'.png'];
    ImagesTrainHombres{i,1} = imread(url);
    ImagesTrainHombres{i,2} = [Anota];
    j = j +1;
    end
    
end

j = 1382;
for i = 1:TamanoValM
    if i<150
    Id =num2str(ImagenesValHombres(i,1));
    Anota =num2str(ImagenesValHombres(i,2));
    url = [Id,'.png'];
    ImagesValHombres{i,1} = imread(url);
    ImagesValHombres{i,2} = [Anota];
     else
    Id =num2str(ImagenesValHombres(j,1));
    Anota =num2str(ImagenesValHombres(j,2));
    url = [Id,'.png'];
    ImagesValHombres{i,1} = imread(url);
    ImagesValHombres{i,2} = [Anota];
    j = j +1;
    end
end


%Ciclo para seleccionar las imagenes de test.
j = 400;
k = 2100;
for i = 1:300
    if i<150 
    Id =num2str(ImagenesHombres(j,1));
    Anota =num2str(ImagenesHombres(j,2));
    url = [Id,'.png'];
    imagenesTest{i,1} = imread(url);
    imagenesTest{i,2} = [Anota];
    imagenesTest{i,3} = 1;
    j = j+1;
    else
    Id =num2str(ImagenesHombres(k,1));
    Anota =num2str(ImagenesHombres(k,2));
    url = [Id,'.png'];
    imagenesTest{i,1} = imread(url);
    imagenesTest{i,2} = [Anota];
    imagenesTest{i,3} = 1;   
    k = k+1;
    end
end
j = 400;
k = 2100;
for i = 301:600
     if i<450 
    Id =num2str(ImagenesMujeres(j,1));
    Anota =num2str(ImagenesMujeres(j,2));
    url = [Id,'.png'];
    imagenesTest{i,1} = imread(url);
    imagenesTest{i,2} = [Anota];
    imagenesTest{i,3} = 0;
    j = j+1;
    else
    Id =num2str(ImagenesMujeres(k,1));
    Anota =num2str(ImagenesMujeres(k,2));
    url = [Id,'.png'];
    imagenesTest{i,1} = imread(url);
    imagenesTest{i,2} = [Anota];
    imagenesTest{i,3} = 0;   
    k = k+1;
     end
end
    
    
    



%  save('ImagenesTrain200.mat','ImagesTrain');
% save('ImagenesVal200.mat','ImagesVal');
% save('ImagenesTrainHombres200.mat','ImagesTrainHombres');
% save('ImagenesValHombres200.mat','ImagesValHombres');
% save('ImagenesTrain200Mujeres.mat','ImagesTrainMujeres');
% save('ImagenesVal200Mujeres.mat','ImagesValMujeres');
%ESTA PARTE ES PARA EL PRE PROCESO DE LAS IMAGENES
%%
%Las imagenes estan desde el 4
%FALTA POR HACER. Toca filtrar las partes larga

% load('ImagenesVal200.mat');
% load('ImagenesTrain200.mat');
% 
% load('ImagenesValHombres200.mat');
% load('ImagenesTrainHombres200.mat');
% 
% load('ImagenesVal200Mujeres.mat');
% load('ImagenesTrain200Mujeres.mat');

Row = 2044;
Column = 1800;
cellSize = 15;

% ImagenesTrain = ImagesTrain;
ImagenesTrainHombres = ImagesTrainHombres;
ImagenesTrainMujeres =ImagesTrainMujeres;
% ImagenesVal= ImagesVal;
ImagenesValHombres = ImagesValHombres;
ImagenesValMujeres =ImagesValMujeres;

% Size = length(ImagenesTrain);
SizeMujeres = length(ImagenesTrainMujeres);
SizeHombres = length(ImagenesTrainHombres);
%Recorrido para sacar HOg de imagenes de prueba
% for i = 1:Size
%     ImagenPrueba  = ImagenesTrain(i,1); 
%     ImagenPrueba = cell2mat(ImagenPrueba);
%     ImagenPrueba = imresize(ImagenPrueba, [Row, Column]);
%      Umbral = graythresh(ImagenPrueba);
%     % Umbral = Umbral*256;
%     Umbral = Umbral*256;
%     Quitar = ImagenPrueba>Umbral;
%     % Quitar = uint8(Quitar);
%     Quitar2 = uint8(Quitar);
%     Quitar2 = Quitar2.*ImagenPrueba;
%     Recons = imreconstruct(Quitar2,ImagenPrueba);
%     % % Filtrado
%     % Comparison = ImagenPrueba>230;
%     Comparison = Quitar2>230;
%     Comparison = uint8(Comparison);
%     Comparison = Comparison*255;
%     Pegarlo = imreconstruct(ImagenPrueba,Quitar2);
%     Add = Pegarlo + Quitar2;
%     Clean = Quitar2 - Comparison;
%     se = ones(7);
%     Clean = imopen(Clean,se);
%     Clean = imreconstruct(Clean,Quitar2);
%     % Se aplica un descriptor de caracteristicas en donde se tomara un
%     % histograma
% %     bord = edge(Clean,'canny');
%     [hog,vis] = extractHOGFeatures(Clean,'CellSize',[32,32]);
%     HogsTrainTodos(i,:) = hog;
% end

for i = 1:SizeMujeres
    ImagenPrueba  = ImagenesTrainMujeres(i,1); 
    ImagenPrueba = cell2mat(ImagenPrueba);
    ImagenPrueba = imresize(ImagenPrueba, [Row, Column]);
     Umbral = graythresh(ImagenPrueba);
    % Umbral = Umbral*256;
    Umbral = Umbral*256;
    Quitar = ImagenPrueba>Umbral;
    % Quitar = uint8(Quitar);
    Quitar2 = uint8(Quitar);
    Quitar2 = Quitar2.*ImagenPrueba;
    Recons = imreconstruct(Quitar2,ImagenPrueba);
    % % Filtrado
    % Comparison = ImagenPrueba>230;
    Comparison = Quitar2>230;
    Comparison = uint8(Comparison);
    Comparison = Comparison*255;
    Pegarlo = imreconstruct(ImagenPrueba,Quitar2);
    Add = Pegarlo + Quitar2;
    Clean = Quitar2 - Comparison;
    se = ones(7);
    Clean = imopen(Clean,se);
    Clean = imreconstruct(Clean,Quitar2);
    % Se aplica un descriptor de caracteristicas en donde se tomara un
    % histograma
%     bord = edge(Clean,'canny');
    [hog,vis] = extractHOGFeatures(Clean,'CellSize',[32,32]);
    HogsTrainMujeres(i,:) = hog;
    Clean = single(Clean);
        HOGSVM = vl_hog(Clean,cellSize);
    HOGSVM = HOGSVM(:);
    HOGSVMTrainMujeres(:,i) = HOGSVM;
end

for i = 1:SizeHombres
    ImagenPrueba  = ImagenesTrainHombres(i,1); 
    ImagenPrueba = cell2mat(ImagenPrueba);
    ImagenPrueba = imresize(ImagenPrueba, [Row, Column]);
     Umbral = graythresh(ImagenPrueba);
    % Umbral = Umbral*256;
    Umbral = Umbral*256;
    Quitar = ImagenPrueba>Umbral;
    % Quitar = uint8(Quitar);
    Quitar2 = uint8(Quitar);
    Quitar2 = Quitar2.*ImagenPrueba;
    Recons = imreconstruct(Quitar2,ImagenPrueba);
    % % Filtrado
    % Comparison = ImagenPrueba>230;
    Comparison = Quitar2>230;
    Comparison = uint8(Comparison);
    Comparison = Comparison*255;
    Pegarlo = imreconstruct(ImagenPrueba,Quitar2);
    Add = Pegarlo + Quitar2;
    Clean = Quitar2 - Comparison;
    se = ones(7);
    Clean = imopen(Clean,se);
    Clean = imreconstruct(Clean,Quitar2);
    % Se aplica un descriptor de caracteristicas en donde se tomara un
    % histograma
%     bord = edge(Clean,'canny');
    [hog,vis] = extractHOGFeatures(Clean,'CellSize',[32,32]);
    HogsTrainHombres(i,:) = hog;
    Clean = single(Clean);
    
    HOGSVM = vl_hog(Clean,cellSize);
    HOGSVM = HOGSVM(:);
    HOGSVMTrainHombres(:,i) = HOGSVM;
end

%Recorrido para sacar HOg de imagenes de test
% for i = 1:Size
%     ImagenPrueba  = ImagenesVal(i,1); 
%     ImagenPrueba = cell2mat(ImagenPrueba);
%     ImagenPrueba = imresize(ImagenPrueba, [Row, Column]);
%      Umbral = graythresh(ImagenPrueba);
%     % Umbral = Umbral*256;
%     Umbral = Umbral*256;
%     Quitar = ImagenPrueba>Umbral;
%     % Quitar = uint8(Quitar);
%     Quitar2 = uint8(Quitar);
%     Quitar2 = Quitar2.*ImagenPrueba;
%     Recons = imreconstruct(Quitar2,ImagenPrueba);
%     % % Filtrado
%     % Comparison = ImagenPrueba>230;
%     Comparison = Quitar2>230;
%     Comparison = uint8(Comparison);
%     Comparison = Comparison*255;
%     Pegarlo = imreconstruct(ImagenPrueba,Quitar2);
%     Add = Pegarlo + Quitar2;
%     Clean = Quitar2 - Comparison;
%     se = ones(7);
%     Clean = imopen(Clean,se);
%     Clean = imreconstruct(Clean,Quitar2);
%     % Se aplica un descriptor de caracteristicas en donde se tomara un
%     % histograma
% %     bord = edge(Clean,'canny');
%     [hog,vis] = extractHOGFeatures(Clean,'CellSize',[32,32]);
%     HogsValTodos(i,:) = hog;
% end

for i = 1:SizeHombres
    ImagenPrueba  = ImagenesValHombres(i,1); 
    ImagenPrueba = cell2mat(ImagenPrueba);
    ImagenPrueba = imresize(ImagenPrueba, [Row, Column]);
     Umbral = graythresh(ImagenPrueba);
    % Umbral = Umbral*256;
    Umbral = Umbral*256;
    Quitar = ImagenPrueba>Umbral;
    % Quitar = uint8(Quitar);
    Quitar2 = uint8(Quitar);
    Quitar2 = Quitar2.*ImagenPrueba;
    Recons = imreconstruct(Quitar2,ImagenPrueba);
    % % Filtrado
    % Comparison = ImagenPrueba>230;
    Comparison = Quitar2>230;
    Comparison = uint8(Comparison);
    Comparison = Comparison*255;
    Pegarlo = imreconstruct(ImagenPrueba,Quitar2);
    Add = Pegarlo + Quitar2;
    Clean = Quitar2 - Comparison;
    se = ones(7);
    Clean = imopen(Clean,se);
    Clean = imreconstruct(Clean,Quitar2);
    % Se aplica un descriptor de caracteristicas en donde se tomara un
    % histograma
%     bord = edge(Clean,'canny');
    [hog,vis] = extractHOGFeatures(Clean,'CellSize',[32,32]);
    HogsValHombres(i,:) = hog;
    Clean = single(Clean);
        HOGSVM = vl_hog(Clean,cellSize);
    HOGSVM = HOGSVM(:);
    HOGSVMValHombres(:,i) =HOGSVM;
end

for i = 1:SizeMujeres
    ImagenPrueba  = ImagenesValMujeres(i,1); 
    ImagenPrueba = cell2mat(ImagenPrueba);
    ImagenPrueba = imresize(ImagenPrueba, [Row, Column]);
     Umbral = graythresh(ImagenPrueba);
    % Umbral = Umbral*256;
    Umbral = Umbral*256;
    Quitar = ImagenPrueba>Umbral;
    % Quitar = uint8(Quitar);
    Quitar2 = uint8(Quitar);
    Quitar2 = Quitar2.*ImagenPrueba;
    Recons = imreconstruct(Quitar2,ImagenPrueba);
    % % Filtrado
    % Comparison = ImagenPrueba>230;
    Comparison = Quitar2>230;
    Comparison = uint8(Comparison);
    Comparison = Comparison*255;
    Pegarlo = imreconstruct(ImagenPrueba,Quitar2);
    Add = Pegarlo + Quitar2;
    Clean = Quitar2 - Comparison;
    se = ones(7);
    Clean = imopen(Clean,se);
    Clean = imreconstruct(Clean,Quitar2);
    % Se aplica un descriptor de caracteristicas en donde se tomara un
    % histograma
%     bord = edge(Clean,'canny');
    [hog,vis] = extractHOGFeatures(Clean,'CellSize',[32,32]);
    HogsValMujeres(i,:) = hog;
    Clean = single(Clean);
    HOGSVM = vl_hog(Clean,cellSize);
    HOGSVM = HOGSVM(:);
    HOGSVMValMujeres(:,i) = HOGSVM; 
end

% for i = 1:length(ImagenesTrain)
%     Age = ImagenesTrain{i,2};
%     Age = str2num(Age);
%     Age = round(Age);
%     %AQUI SE HACE CLASIFICACION BINARIA A TRAVES DE LA MITAD DE LA EDAD DE
%     %LAS IMAGENES. Es decir, se habilita esta seccion para hacerlo binario
%     % Para posteriormente hacerlo jerarquico.
% %     
% %     if Age > 6
% %         Age2 = -1;
% %     else
% %         Age2 = 1;
% %     end
%     Etiquetas(i) = Age;
% end
for i = 1:length(ImagenesTrainMujeres)
    Age = ImagenesTrainMujeres{i,2};
    Age = str2num(Age);
    Age = round(Age);
    %AQUI SE HACE CLASIFICACION BINARIA A TRAVES DE LA MITAD DE LA EDAD DE
    %LAS IMAGENES. Es decir, se habilita esta seccion para hacerlo binario
    % Para posteriormente hacerlo jerarquico.
%     
    if Age > 9
        Age2 = -1;
    else
        Age2 = 1;
    end
    EtiquetasMujeres(i) = Age;
    EtiquetasBinTrainMuj(i) = Age2;
end
for i = 1:length(ImagenesTrainHombres)
    Age = ImagesTrainHombres{i,2};
    Age = str2num(Age);
    Age = round(Age);
    %AQUI SE HACE CLASIFICACION BINARIA A TRAVES DE LA MITAD DE LA EDAD DE
    %LAS IMAGENES. Es decir, se habilita esta seccion para hacerlo binario
    % Para posteriormente hacerlo jerarquico.
%     
    if Age > 9
        Age2 = -1;
    else
        Age2 = 1;
    end
    EtiquetasHombres(i) = Age;
    EtiquetasBinTrainHom(i) = Age2;
end
% for i = 1:length(ImagenesVal)
%     Age = ImagenesVal{i,2};
%     Age = str2num(Age);
%     Age = round(Age);
%     %AQUI SE HACE CLASIFICACION BINARIA A TRAVES DE LA MITAD DE LA EDAD DE
%     %LAS IMAGENES. Es decir, se habilita esta seccion para hacerlo binario
% %     % Para posteriormente hacerlo jerarquico.
% %     if Age > 6
% %         Age = -1;
% %     else
% %         Age = 1;
% %     end
%      EtiquetasVal(i) = Age;
% end
for i = 1:length(ImagenesValMujeres)
    Age = ImagenesValMujeres{i,2};
    Age = str2num(Age);
    Age = round(Age);
    %AQUI SE HACE CLASIFICACION BINARIA A TRAVES DE LA MITAD DE LA EDAD DE
    %LAS IMAGENES. Es decir, se habilita esta seccion para hacerlo binario
%     % Para posteriormente hacerlo jerarquico.
    if Age > 9
        Age2 = -1;
    else
        Age2 = 1;
    end
     EtiquetasValMujeres(i) = Age;
     EtiquetasBinValMuj(i) = Age2;
end
for i = 1:length(ImagenesValHombres)
    Age = ImagenesValHombres{i,2};
    Age = str2num(Age);
    Age = round(Age);
    %AQUI SE HACE CLASIFICACION BINARIA A TRAVES DE LA MITAD DE LA EDAD DE
    %LAS IMAGENES. Es decir, se habilita esta seccion para hacerlo binario
%     % Para posteriormente hacerlo jerarquico.
    if Age > 9
        Age2 = -1;
    else
        Age2 = 1;
    end
     EtiquetasValHombres(i) = Age;
     EtiquetasBinValHom(i) = Age2;
end

% Etiquetas =  Etiquetas';
% EtiquetasVal = EtiquetasVal';
EtiquetasMujeres =  EtiquetasMujeres';
EtiquetasValMujeres = EtiquetasValMujeres';
EtiquetasHombres =  EtiquetasHombres';
EtiquetasValHombres = EtiquetasValHombres';
EtiquetasBinTrainHom = EtiquetasBinTrainHom';
EtiquetasBinValHom = EtiquetasBinValHom';
EtiquetasBinTrainMuj = EtiquetasBinTrainMuj';
EtiquetasBinValMuj = EtiquetasBinValMuj';


% Etiquetas = single(Etiquetas);
EtiquetasHombres = single(EtiquetasHombres);
EtiquetasMujeres = single(EtiquetasMujeres); 
% EtiquetasVal = single(EtiquetasVal);
EtiquetasValHombres = single(EtiquetasValHombres);
EtiquetasValMujeres = single(EtiquetasValMujeres);

EtiquetasBinTrainHom = single(EtiquetasBinTrainHom);
EtiquetasBinValHom = single(EtiquetasBinValHom);
EtiquetasBinTrainMuj = single(EtiquetasBinTrainMuj);
EtiquetasBinValMuj = single(EtiquetasBinValMuj);


% Model = fitcknn(HogsTrainTodos,Etiquetas,'NumNeighbors',10,'Standardize',1);
ModelMujeres = fitcknn(HogsTrainMujeres,EtiquetasMujeres,'NumNeighbors',9,'Standardize',1);
ModelHombres = fitcknn(HogsTrainHombres,EtiquetasHombres,'NumNeighbors',9,'Standardize',1);

ModelMujeresBin =fitcknn(HogsTrainMujeres,EtiquetasBinTrainMuj,'NumNeighbors',9,'Standardize',1);
ModelHombresBin =fitcknn(HogsTrainMujeres,EtiquetasBinTrainHom,'NumNeighbors',9,'Standardize',1);

%  ModelMujeres = fitcknn(HogsTrainMujeres,EtiquetasMujeres);
%  ModelHombres = fitcknn(HogsTrainHombres,EtiquetasHombres);
% Se obtiene el modelo para hacer la clasificacion de los tejidos Y SE VA A
% va a utilizar la funcion predict.
% DatosPrueba
%%
% [PredictionTrain] = predict(Model,HogsTrainTodos);
% [PredictionVal] = predict(Model,HogsValTodos);
[PredictionTrainMujeres] = predict(ModelMujeres,HogsTrainMujeres);
[PredictionValMujeres] = predict(ModelMujeres,HogsValMujeres);

[PredictionTrainHombres] = predict(ModelHombres,HogsTrainHombres);
[PredictionValHombres] = predict(ModelHombres,HogsValHombres);

[PredictionTrainBINMujeres] = predict(ModelMujeresBin,HogsTrainMujeres);
[PredictionValBINMujeres] = predict(ModelMujeresBin,HogsValMujeres);

[PredictionTrainBINHombres] = predict(ModelHombresBin,HogsTrainHombres);
[PredictionValBINHombres] = predict(ModelHombresBin,HogsValHombres);

% Lo que nos da predict va a ser la clasificacion del vector del cual fue
% metido.
% Calculo del aca a trave[es de la definision de la matriz de confusion
% MatrizTrain = confusionmat(PredictionTrain,Etiquetas);
% MatrizVal = confusionmat(PredictionVal,EtiquetasVal);
MatrizTrainMujeres = confusionmat(PredictionTrainMujeres,EtiquetasMujeres);
MatrizValMujeres = confusionmat(PredictionValMujeres,EtiquetasValMujeres);
MatrizTrainHombres = confusionmat(PredictionTrainHombres,EtiquetasHombres);
MatrizValHombres = confusionmat(PredictionValHombres,EtiquetasValHombres);

MatrizTrainBinMujeres = confusionmat(PredictionTrainBINMujeres,EtiquetasBinTrainMuj);
MatrizValBinMujeres = confusionmat(PredictionValBINMujeres,EtiquetasBinValMuj);
MatrizTrainBinHombres = confusionmat(PredictionTrainBINHombres,EtiquetasBinTrainHom);
MatrizValBinHombres = confusionmat(PredictionValBINHombres,EtiquetasBinValHom);
% for i= 1:18
%     % Se normaliza la matriz de confusion
%    MatrizTrain(:,i) = MatrizTrain(:,i)/sum(MatrizTrain(:,i)); 
%    MatrizVal(:,i) = MatrizVal(:,i)/sum(MatrizVal(:,i)); 
% end
for i= 1:18
    % Se normaliza la matriz de confusion
   MatrizTrainMujeres(:,i) = MatrizTrainMujeres(:,i)/sum(MatrizTrainMujeres(:,i)); 
   
end
for i= 1:19
    % Se normaliza la matriz de confusion 
   MatrizTrainHombres(:,i) = MatrizTrainHombres(:,i)/sum(MatrizTrainHombres(:,i));
   
end



for i= 1:17
    % Se normaliza la matriz de confusion
    MatrizValMujeres(:,i) = MatrizValMujeres(:,i)/sum(MatrizValMujeres(:,i)); 

end

for i= 1:18
    % Se normaliza la matriz de confusion 
   MatrizValHombres(:,i) = MatrizValHombres(:,i)/sum(MatrizValHombres(:,i)); 
end



for i= 1:2
    % Se normaliza la matriz de confusion
   MatrizTrainBinMujeres(:,i) = MatrizTrainBinMujeres(:,i)/sum(MatrizTrainBinMujeres(:,i)); 
   MatrizTrainBinHombres(:,i) = MatrizTrainBinHombres(:,i)/sum(MatrizTrainBinHombres(:,i));
end
for i= 1:2
    % Se normaliza la matriz de confusion
    MatrizValBinMujeres(:,i) = MatrizValBinMujeres(:,i)/sum(MatrizValBinMujeres(:,i)); 
   MatrizValBinHombres(:,i) = MatrizValBinHombres(:,i)/sum(MatrizValBinHombres(:,i)); 
end

% ACAvalueTrain = mean(diag(MatrizTrain));
% ACAvalueVal = mean(diag(MatrizVal));
ACAvalueTrainMujeres = mean(diag(MatrizTrainMujeres));
ACAvalueValMujeres = mean(diag(MatrizValMujeres));

ACAvalueTrainHombres = mean(diag(MatrizTrainHombres));
ACAvalueValHombres = mean(diag(MatrizValHombres));


ACAvalueTrainBinMujeres = mean(diag(MatrizTrainBinMujeres));
ACAvalueValBinMujeres = mean(diag(MatrizValBinMujeres));

ACAvalueTrainBinHombres = mean(diag(MatrizTrainBinHombres));
ACAvalueValBinHombres = mean(diag(MatrizValBinHombres));
% disp('ACA train:');
% disp(ACAvalueTrain);
% disp('ACA val:');
% disp(ACAvalueVal);
disp('ACA train Mujeres:');
disp(ACAvalueTrainMujeres);

disp('ACA val Mujeres:');
disp(ACAvalueValMujeres);

disp('ACA train Hombres:');
disp(ACAvalueTrainHombres);
    
disp('ACA val Hombres:');
disp(ACAvalueValHombres);


disp('ACA train Binario Mujeres:');
disp(ACAvalueTrainBinMujeres);

disp('ACA val Binario Mujeres:');
disp(ACAvalueValBinMujeres);

disp('ACA train Binario Hombres:');
disp(ACAvalueTrainBinHombres);
    
disp('ACA val Binario Hombres:');
disp(ACAvalueValBinHombres);

%%
%Se asignan etiquetas binarias
%  save('ModeloHombres','ModelHombres');
% save('ModeloMujeres','ModelMujeres');
clc
clear EtiquetasMujSVM
clear EtiquetasHomSVM
clear WMujeres
clear BMujeres
for i = 1:length(EtiquetasHombres)
   if EtiquetasHombres(i) >=6
       EtiquetasHomSVM(i) = 1;
   else
       EtiquetasHomSVM(i) = -1;
   end 
end

for i = 1:length(EtiquetasMujeres)
   if EtiquetasMujeres(i) >=6
       EtiquetasMujSVM(i) = 1;
   else
       EtiquetasMujSVM(i) = -1;
   end 
end

for i = 1:length(EtiquetasValHombres)
   if EtiquetasValHombres(i) >=6
       EtiquetasValHomSVM(i) = 1;
   else
       EtiquetasValHomSVM(i) = -1;
   end 
end

for i = 1:length(EtiquetasValMujeres)
   if EtiquetasHombres(i) >=6
       EtiquetasValMujSVM(i) = 1;
   else
       EtiquetasValMujSVM(i) = -1;
   end 
end
% EtiquetasValMujSVM = EtiquetasValMujSVM';
% EtiquetasValHomSVM = EtiquetasValHomSVM';
% EtiquetasMujSVM = EtiquetasMujSVM';
% EtiquetasHomSVM = EtiquetasHomSVM';
% EtiquetasMujSVM =  single(EtiquetasMujSVM);
% EtiquetasHomSVM =  single(EtiquetasHomSVM);

[Wmujeres Bmujeres] = vl_svmtrain(HOGSVMTrainMujeres,EtiquetasMujSVM,0.01);
  
[Whombres BHombres] = vl_svmtrain(HOGSVMTrainHombres,EtiquetasHomSVM,0.01);

PredictionTrainMujeres = Wmujeres'*HOGSVMTrainMujeres + Bmujeres;
PrecitionTrainMujeres = PredictionTrainMujeres';

PredictionValMujeres = Wmujeres'*HOGSVMValMujeres + Bmujeres;
PrecitionValMujeres = PredictionValMujeres';

PredictionTrainHombres = Whombres'*HOGSVMTrainHombres + BHombres;
PrecitionTrainHombres = PredictionTrainHombres';

PredictionValHombres = Whombres'*HOGSVMValHombres+ BHombres;
PrecitionValHombres = PredictionValHombres';


for i = 1:length(EtiquetasValMujeres)
    Value = PredictionTrainMujeres(i);
    if Value < 0
        PredictionTrainMujeres(i) = -1;
    else
        PredictionTrainMujeres(i) = 1;
    end
end
for i = 1:length(EtiquetasValMujeres)
    Value = PredictionValMujeres(i);
    if Value < 0
        PredictionValMujeres(i) = -1;
    else
        PredictionValMujeres(i) = 1;
    end
end

for i = 1:length(EtiquetasValHombres)
    Value = PredictionTrainHombres(i);
    if Value < 0
        PredictionTrainHombres(i) = -1;
    else
        PredictionTrainHombres(i) = 1;
    end
end
for i = 1:length(EtiquetasValHombres)
    Value = PredictionValHombres(i);
    if Value < 0
        PredictionValHombres(i) = -1;
    else
        PredictionValHombres(i) = 1;
    end
end

EtiquetasMujSVM = single(EtiquetasMujSVM);
EtiquetasValMujSVM = single(EtiquetasValMujSVM);
%Se crea la matriz de confusion.
MatrizTrainWOMEN = confusionmat(PredictionTrainMujeres,EtiquetasMujSVM);
MatrizValWOMEN = confusionmat(PredictionValMujeres,EtiquetasValMujSVM);


EtiquetasHomSVM = single(EtiquetasHomSVM);
EtiquetasValHomSVM = single(EtiquetasValHomSVM);
%Se crea la matriz de confusion.
MatrizTrainMEN = confusionmat(PredictionTrainHombres,EtiquetasHomSVM);
MatrizValMEN = confusionmat(PredictionValHombres,EtiquetasValHomSVM);

for i= 1:2
    % Se normaliza la matriz de confusion
   MatrizTrainWOMEN(:,i) = MatrizTrainWOMEN(:,i)/sum(MatrizTrainWOMEN(:,i)); 
   MatrizValWOMEN(:,i) = MatrizValWOMEN(:,i)/sum(MatrizValWOMEN(:,i)); 
   
      MatrizTrainMEN(:,i) = MatrizTrainMEN(:,i)/sum(MatrizTrainMEN(:,i)); 
   MatrizValMEN(:,i) = MatrizValMEN(:,i)/sum(MatrizValMEN(:,i)); 
end

%Se obtiene el ACA.
ACAvalueTrainWOMEN = mean(diag(MatrizTrainWOMEN));
ACAvalueValWOMEN = mean(diag(MatrizValWOMEN));

ACAvalueTrainMEN = mean(diag(MatrizTrainMEN));
ACAvalueValMEN = mean(diag(MatrizValMEN));
% correr fitcknn con clases binarias


