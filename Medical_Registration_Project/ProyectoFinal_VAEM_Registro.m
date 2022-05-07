%% PART 1 – 3D registration 
close all 
clear
%% Leer y mostrar volúmenes
% Esta es la primera sección del proyecto donde se van a leer y mostrar
% todos los cortes de los volúmenes

%% Volumen fijo: CT / Volumen Móvil: PET

% First - Implementation of image registration.
%to obtain the metadata associated with each image.
FixedHeader = helperReadHeaderRIRE('./VolumeData1/pac002CT.header'); %pac00CT fixedImage
MovingHeader = helperReadHeaderRIRE('./VolumeData1/pac002PET.header' ); %pac00PET movingImage
Vol_size_F = [FixedHeader.Rows, FixedHeader.Columns, FixedHeader.Slices]; %Get information image
Volume_fixed = multibandread('./VolumeData1/pac002CT.bin', Vol_size_F, 'int16=>int16', 0, 'bsq', 'ieee-be' ); %  to read the binary files that contain image dataa
Volume_fixed_S = Volume_fixed;
Vol_size_M = [MovingHeader.Rows, MovingHeader.Columns, MovingHeader.Slices]; 
Volume_moving = multibandread('./VolumeData1/pac002PET.bin', Vol_size_M, 'int16=>int16', 0, 'bsq', 'ieee-be' );
helperVolumeRegistration(Volume_fixed,Volume_moving); % This function is useful to check the quality of 3-D registration results (interactive).
centerFixed = round(size(Volume_fixed)/2); %get centerImage
centerMoving = round(size(Volume_moving)/2);
figure, imshowpair(Volume_moving(:,:,12),Volume_fixed(:,:,12)); 
title('Fixed image CT'); %get a general idea of the registration result.
%optimizer: defines the methodology for min or max the similarity metric.
%metric: returns a scalar value that describes how similar the images are.
%They are objects whose properties control the registration.
%Different intensity distributions (multimodal configuration).
[optimizer,metric] = imregconfig('multimodal'); % creates optimizer and metric configurations that we pass to imregister.
%stores the relationship among: intrinsic coordinates anchored (columns,
%rows, planes 3D image)and spatial location of the same in a world
%coordinate system.
Rfixed  = imref3d(size(Volume_fixed),FixedHeader.PixelSize(2),FixedHeader.PixelSize(1),FixedHeader.SliceThickness);
Rmoving = imref3d(size(Volume_moving),MovingHeader.PixelSize(2),MovingHeader.PixelSize(1),MovingHeader.SliceThickness);
%% Volumen fijo: PET / Volumen Móvil: CT

% Lectura y visualización
% First - Implementation of image registration.
%to obtain the metadata associated with each image.
FixedHeader_PET = helperReadHeaderRIRE('./VolumeData1/pac002PET.header'); %pac00PET fixedImage
MovingHeader_CT = helperReadHeaderRIRE('./VolumeData1/pac002CT.header'); %pac00CT movingImage
Vol_size_PET = [FixedHeader_PET.Rows, FixedHeader_PET.Columns, FixedHeader_PET.Slices]; %Get information image
Volume_PET = multibandread('./VolumeData1/pac002PET.bin', Vol_size_PET, 'int16=>int16', 0, 'bsq', 'ieee-be' ); %  to read the binary files that contain image dataa
Vol_size_CT = [MovingHeader_CT.Rows, MovingHeader_CT.Columns, MovingHeader_CT.Slices]; 
Volume_CT = multibandread('./VolumeData1/pac002CT.bin', Vol_size_CT, 'int16=>int16', 0, 'bsq', 'ieee-be' );
% Visualización figura 3 del proyecto final
helperVolumeRegistration(Volume_PET,Volume_CT); % This function is useful to check the quality of 3-D registration results (interactive).
centerFixed1 = round(size(Volume_PET)/2); %get centerImage
centerMoving1 = round(size(Volume_CT)/2);
figure, imshowpair(Volume_CT(:,:,12),Volume_PET(:,:,12));  %get a general idea of the registration result.
title('Fixed Image PET')
%optimizer: defines the methodology for min or max the similarity metric.
%metric: returns a scalar value that describes how similar the images are.
%They are objects whose properties control the registration.
%Different intensity distributions (multimodal configuration).
[optimizer1,metric1] = imregconfig('multimodal'); % creates optimizer and metric configurations that we pass to imregister.
%stores the relationship among: intrinsic coordinates anchored (columns,
%rows, planes 3D image)and spatial location of the same in a world
%coordinate system.
Rfixed1  = imref3d(size(Volume_PET),FixedHeader_PET.PixelSize(2),FixedHeader_PET.PixelSize(1),FixedHeader_PET.SliceThickness);
Rmoving1 = imref3d(size(Volume_CT),MovingHeader_CT.PixelSize(2),MovingHeader_CT.PixelSize(1),MovingHeader_CT.SliceThickness);
%% Visualización de la figura 2 del proyecto
figure, subplot(1,2,1);imshowpair(Volume_PET(:,:,12),Volume_CT(:,:,12));title('Image Fixed CT');
subplot(1,2,2);imshowpair(Volume_CT(:,:,12),Volume_PET(:,:,12));title('Image Fixed PET');
%% Mostrando todos los cortes iniciales
% Volumen fijo: CT / Volumen Móvil: PET
z=0;
axial = 0;
for c = 1:size(Volume_moving,3)
  z =c; 
  axial = axial + 1;
    figure, imshowpair(Volume_moving(:,:,c), Volume_fixed(:,:,z)); title("Corte Axial " + axial + " - Volumen fijo: CT / Volumen Móvil: PET" )
end
%% Mostrando todos los cortes iniciales
% Volumen fijo: PET / Volumen Móvil: CT
j=0;
axial = 0;
for c = 1:size(Volume_PET,3)
  j =c; 
  axial = axial + 1;
    figure, imshowpair(Volume_CT(:,:,c), Volume_PET(:,:,j)); title("Corte Axial " + axial + " - Volumen fijo: PET / Volumen Móvil: CT" )
end
%% Registro Inicial
% En esta sección se realizó el registro inicial para elegir qué
% volumen fijo es elegido para seguir trabajando a lo largo de la primera 
% parte de este proyecto final

%% Volumen fijo: CT / Volumen Móvil: PET - Rigid Transformation
tic
movingRegisteredVolume1 = imregister(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',1);
toc
%helperVolumeRegistration(Volume_fixed,movingRegisteredVolume1);
figure,imshowpair(movingRegisteredVolume1(:,:,13),Volume_fixed(:,:,13)); title('Rigid Registration Fixed Image CT')
%% Mostrando todos los cortes axiales del registro rigid 
% Volumen fijo: CT / Volumen Móvil: PET
w=0;
axial = 0;
for c = 1:size(movingRegisteredVolume1,3)
  w =c; 
  axial = axial + 1;
    figure, imshowpair(movingRegisteredVolume1(:,:,c), Volume_fixed(:,:,w)); title("Corte Axial " + axial + " - Volumen fijo: CT / Volumen Móvil: PET" )
end
%% Volumen fijo: PET / Volumen Móvil: CT - Rigid Transformation
tic
movingRegisteredVolume12 = imregister(Volume_CT,Rmoving1,Volume_PET,Rfixed1, 'rigid', optimizer1, metric1, 'PyramidLevels',2);
toc
%helperVolumeRegistration(Volume_PET,movingRegisteredVolume12);
figure,imshowpair(movingRegisteredVolume12(:,:,7),Volume_PET(:,:,7)); title('Rigid Registration Fixed Image PET')
%% Mostrando todos los cortes axiales del registro rigid 
% Volumen fijo: PET / Volumen Móvil: CT
r=0;
axial = 0;
for c = 1:size(movingRegisteredVolume12,3)
  r =c; 
  axial = axial + 1;
    figure, imshowpair(movingRegisteredVolume12(:,:,c), Volume_PET(:,:,r)); title("Corte Axial " + axial + " - Volumen fijo: PET / Volumen Móvil: CT" )
end
%% Subplot visualización figura 4 del proyecto final
figure,subplot(1,2,1); imshowpair(movingRegisteredVolume1(:,:,13),Volume_fixed(:,:,13)); title('Rigid Registration Fixed Image CT')
subplot(1,2,2);imshowpair(movingRegisteredVolume12(:,:,7),Volume_PET(:,:,7));title('Rigid Registration Fixed Image PET');
% Visualización figura 5 del proyecto final
helperVolumeRegistration(Volume_PET,movingRegisteredVolume12);
%%
% Visualizando 3 cortes axiales de la transformación rígida
figure, subplot (1,3,1),imshowpair(movingRegisteredVolume1(:,:,13),Volume_fixed(:,:,13)); title('#13')
subplot (1,3,2),imshowpair(movingRegisteredVolume1(:,:,10),Volume_fixed(:,:,10)); title('#10')
subplot (1,3,3),imshowpair(movingRegisteredVolume1(:,:,centerFixed(3)), Volume_fixed(:,:,centerFixed(3))); title('Volume Center')
%% Evaluación Inicial
% En esta sección se realizó la evaluación inicial para elegir con base a
% las métricas de evaluación: histograma conjunto, entropía individual,
% entropía conjunta e información mutua.
%% Evaluación Registro 1 Volumen fijo: CT / Volumen Móvil: PET - Rigid Transformation
%Evaluación realizada a cada registro 
%Histograma conjunto
jointHistogram_Rigid = vaem_joint_histogram (movingRegisteredVolume1, Volume_fixed);
figure, imshow (jointHistogram_Rigid); title('Joint Histogram registration 1');
%Entropía conjunta
jointEntropy_Rigid = vaem_joint_entropy (movingRegisteredVolume1,Volume_fixed);
%Entropía individual
Entropy_Rigid_A = vaem_entropy(movingRegisteredVolume1);
Entropy_Rigid_B = vaem_entropy(Volume_fixed);
%Información mutua 
mutualInformation_Rigid = vaem_mutual_information(Entropy_Rigid_A,Entropy_Rigid_B,jointEntropy_Rigid);
%% Evaluación Registro 2 Volumen fijo: PET / Volumen Móvil: CT - Rigid Transformation
jointHistogram_Rigid1 = vaem_joint_histogram (movingRegisteredVolume12, Volume_PET);
figure, imshow (jointHistogram_Rigid1); title('Joint Histogram registration 2');
jointEntropy_Rigid1 = vaem_joint_entropy (movingRegisteredVolume12,Volume_PET);
Entropy_Rigid_A1 = vaem_entropy(movingRegisteredVolume12);
Entropy_Rigid_B1 = vaem_entropy(Volume_PET);
mutualInformation_Rigid1 = Entropy_Rigid_A1 + Entropy_Rigid_B1 - jointEntropy_Rigid1;
%% Subplot figura 6 histogramas conjuntos
figure, subplot (1,2,1); imshow(jointHistogram_Rigid); title('Joint Histogram registration 1');
subplot (1,2,2); imshow(jointHistogram_Rigid1); title('Joint Histogram registration 2');
%% Mejorando el registro
% En esta sección se probaron diferentes técnicas para intentar mejorar el registro
% 1. Las técnicas aplicadas fueron: Tipos de transformaciones affine y
% similarity; filtros; operadores morfológicos; Matrices de
% transformaciones iniciales.
%% Segmentación volumen fijo
% Se realizó una segmentación por umbralización del volumen fijo para poder
%tener un mejor críterio visual de evaluación con el resto de tipos de
% transformaciones
%% Segmentación por umbralización
Volume_fixed_Seg = (Volume_fixed>300)&(Volume_fixed<3000);
%% Registro 1 Volumen fijo: CT / Volumen Móvil: PET - Affine Transformation
tic
movingRegisteredVolume = imregister(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'affine', optimizer, metric, 'PyramidLevels',2);
toc
%helperVolumeRegistration(Volume_fixed,movingRegisteredVolume); title('Affine');
%% Registro 1 Volumen fijo: CT / Volumen Móvil: PET - Similarity Transformation
tic
movingRegisteredVolume2 = imregister(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'Similarity', optimizer, metric, 'PyramidLevels',2);
toc
%helperVolumeRegistration(Volume_fixed,movingRegisteredVolume2); title('Similarity');

%% Subplot figura 7 - visualización de los cortes axiales # 13 y 10
% Volumen fijo segmentado *Solo se utilizó la segmentación para visualización
% no se utilizó para registrar los volúmenes*
figure, subplot (2,3,1),imshowpair(movingRegisteredVolume1(:,:,13), Volume_fixed_Seg(:,:,13)); title('Rigid')
subplot (2,3,2), imshowpair(movingRegisteredVolume(:,:,13), Volume_fixed_Seg(:,:,13)); title('Affine')
subplot (2,3,3), imshowpair(movingRegisteredVolume2(:,:,13), Volume_fixed_Seg(:,:,13)); title('Similarity')
subplot (2,3,4),imshowpair(movingRegisteredVolume1(:,:,10), Volume_fixed_Seg(:,:,10)); title('Rigid')
subplot (2,3,5), imshowpair(movingRegisteredVolume(:,:,10), Volume_fixed_Seg(:,:,10)); title('Affine')
subplot (2,3,6), imshowpair(movingRegisteredVolume2(:,:,10), Volume_fixed_Seg(:,:,10)); title('Similarity')
%% Evaluación 
% En esta sección se evaluaron las métricas para los registros conseguidos
% anteriormente affine y similarity con el objetivo de compararlas con las
% métricas del registro 1 rigid conseguido en la sección de registro
% inicial.
%% Evaluación Volumen fijo: CT / Volumen Móvil: PET - Affine Transformation 
%Histograma conjunto
jointHistogram_Affine = vaem_joint_histogram (movingRegisteredVolume, Volume_fixed);
figure, imshow (jointHistogram_Affine); title('Joint Histogram registration 2');
%Entropía conjunta
jointEntropy_Affine = vaem_joint_entropy (movingRegisteredVolume,Volume_fixed);
%Entropía individual
Entropy_Affine_A = vaem_entropy(movingRegisteredVolume);
Entropy_Affine_B = vaem_entropy(Volume_fixed);
%Información mutua 
mutualInformation_Affine = vaem_mutual_information(Entropy_Affine_A,Entropy_Affine_B,jointEntropy_Affine);
%% Evaluación Volumen fijo: CT / Volumen Móvil: PET - Similarity Transformation 
%Histograma conjunto
jointHistogram_Similarity = vaem_joint_histogram (movingRegisteredVolume2, Volume_fixed);
figure, imshow (jointHistogram_Similarity); title('Joint Histogram registration 3');
%Entropía conjunta
jointEntropy_Similarity = vaem_joint_entropy (movingRegisteredVolume2,Volume_fixed);
%Entropía individual
Entropy_Similarity_A = vaem_entropy(movingRegisteredVolume2);
Entropy_Similarity_B = vaem_entropy(Volume_fixed);
%Información mutua 
mutualInformation_Similarity = vaem_mutual_information(Entropy_Similarity_A,Entropy_Similarity_B,jointEntropy_Similarity);
%% Subplot figura 8 histogramas conjuntos
figure, subplot (3,1,1); imshow(jointHistogram_Rigid); title('Joint Histogram registration 1');
subplot (3,1,2); imshow(jointHistogram_Affine); title('Joint Histogram registration 2');
subplot (3,1,3); imshow(jointHistogram_Similarity); title('Joint Histogram registration 3');
%% Subplot figura 9 del proyecto final donde se muestran los cortes axiales
%13, 10 y el volume center para el registro 1 rigid del registro inicial
figure, subplot(1,3,1);imshowpair(movingRegisteredVolume1(:,:,13), Volume_fixed(:,:,13)); title('Rigid 13')
subplot(1,3,2); imshowpair(movingRegisteredVolume1(:,:,10), Volume_fixed(:,:,10)); title('Rigid 10')
subplot(1,3,3); imshowpair(movingRegisteredVolume1(:,:,centerFixed(3)), Volume_fixed(:,:,centerFixed(3))); title('Volume Center')
%% Preprocesamiento
%Filtros aplicados buscando una mejora en el registro. Contiene morfología
%y filtros espaciales para suavizar o realzar detalle del volumen fijo.
%% Log filter
h = fspecial3('log');
C1=imfilter(Volume_fixed_S, h);
figure, imshowpair(Volume_moving(:,:,12),C1(:,:,12));
%% Average filter
C2 = imboxfilt3(Volume_fixed);
figure, imshowpair(Volume_moving(:,:,12),Volume_fixed(:,:,12));
%% Gaussian filter
C = imgaussfilt3(Volume_fixed);
figure, imshowpair(Volume_moving(:,:,12),C(:,:,12));
%% ellipsoid filter
h1 = fspecial3('ellipsoid');
C3=imfilter(Volume_fixed_S, h1);
figure, imshowpair(Volume_moving(:,:,12),C3(:,:,12));
%% laplacian filter
h2 = fspecial3('laplacian');
C4=imfilter(Volume_fixed_S, h2);
figure, imshowpair(Volume_moving(:,:,12),C4(:,:,12));
%% prewitt filter
h3 = fspecial3('prewitt');
C5=imfilter(Volume_fixed_S, h3);
figure, imshowpair(Volume_moving(:,:,12),C5(:,:,12));
%% sobel filter
h4 = fspecial3('sobel');
C5=imfilter(Volume_fixed_S, h4);
figure, imshowpair(Volume_moving(:,:,12),C5(:,:,12));
%% Open
SE = strel('disk',2);
T = imopen(Volume_fixed,SE);
figure, imshowpair(Volume_moving(:,:,12),T(:,:,12));
%% Close
SE = strel('disk',10);
T = imclose(Volume_fixed,SE);
figure, imshowpair(Volume_moving(:,:,12),T(:,:,12));

%% Registros con preprocesamiento del volumen fijo CT
% Abajo se probaron todos los filtros aplicados al volumen fijo CT
% aplicando registros 
%% Rigid Transformation log filter
tic
movingRegisteredVolumelog = imregister(Volume_moving,Rmoving,C1,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',2);
toc
%helperVolumeRegistration(Volume_fixed,movingRegisteredVolumelog); title('Rigid');
%% Rigid Transformation average filter
tic
movingRegisteredVolumeAv = imregister(Volume_moving,Rmoving,C2,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',2);
toc
%helperVolumeRegistration(Volume_fixed,movingRegisteredVolumeAv); title('Rigid');
%% Rigid Transformation gaussian filter
tic
movingRegisteredVolumeGau = imregister(Volume_moving,Rmoving,C,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',2);
toc
%helperVolumeRegistration(Volume_fixed,movingRegisteredVolumeGau); title('Rigid');
%% Visualización de la figura 10 del proyecto final, se utilizó el corte axial 13
figure, subplot (1,3,1),imshowpair(movingRegisteredVolume1(:,:,13), C1(:,:,13)); title('Log filter')
subplot (1,3,2), imshowpair(movingRegisteredVolume(:,:,13), C2(:,:,13)); title('Average filter')
subplot (1,3,3), imshowpair(movingRegisteredVolume2(:,:,13), C(:,:,13)); title('Gaussian filter')
%% Evaluación registro rigid con volumen fijo CT preprocesado
% En esta sección se realizo la evaluación para los registros realizado con
% el volumen fijo preprocesado
%% Evaluación Volumen fijo: CT / Volumen Móvil: PET - Rigid filtro: log
jointHistogram_Rigidlog = vaem_joint_histogram (movingRegisteredVolumelog, C1);
figure, imshow (jointHistogram_Rigidlog); title('Joint Histogram registration 3');
jointEntropy_Rigidlog = vaem_joint_entropy (movingRegisteredVolumelog,C1);
Entropy_log_A = vaem_entropy(movingRegisteredVolumelog);
Entropy_log_B = vaem_entropy(C1);
mutualInformation_Rigidlog = vaem_mutual_information(Entropy_log_A,Entropy_log_B,jointEntropy_Rigidlog);
%% Evaluación Volumen fijo: CT / Volumen Móvil: PET - Rigid filtro: average
jointHistogram_Rigidav = vaem_joint_histogram (movingRegisteredVolumeAv, C2);
figure, imshow (jointHistogram_Rigidav); title('Joint Histogram registration 3');
jointEntropy_Rigidav = vaem_joint_entropy (movingRegisteredVolumeAv,C2);
Entropy_av_A = vaem_entropy(movingRegisteredVolumeAv);
Entropy_av_B = vaem_entropy(C2);
mutualInformation_Rigidav = vaem_mutual_information(Entropy_av_A,Entropy_av_B,jointEntropy_Rigidav);
%% Evaluación Volumen fijo: CT / Volumen Móvil: PET - Rigid filtro: gaussian
jointHistogram_Rigidgau = vaem_joint_histogram (movingRegisteredVolumeGau, C);
figure, imshow (jointHistogram_Rigidgau); title('Joint Histogram registration 3');
jointEntropy_Rigidgau = vaem_joint_entropy (movingRegisteredVolumeGau,C);
Entropy_gau_A = vaem_entropy(movingRegisteredVolumeGau);
Entropy_gau_B = vaem_entropy(C);
mutualInformation_Rigidgau = vaem_mutual_information(Entropy_gau_A,Entropy_gau_B,jointEntropy_Rigidgau);
%% Visualizaciones de los histogramas conjuntos de el registro con un volumen
%fijo preprocesado Subplot figura 8 histogramas conjuntos
figure, subplot (3,1,1); imshow(jointHistogram_Rigidlog); title('Joint Histogram registration Log');
subplot (3,1,2); imshow(jointHistogram_Rigidav); title('Joint Histogram registration Average');
subplot (3,1,3); imshow(jointHistogram_Rigidgau); title('Joint Histogram registration Gaussian');
%% Matrices de transformación figura 11 del proyecto final
geomtform = imregtform(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',1);
geotformav= imregtform(Volume_moving,Rmoving,C2,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',1);
%% Mejorando el registro con parámetros de optimización 
% En esta sección se realizaron pruebas de registros variando los
% parámetros de optimizer
%% Rigid Transformation UnitialRadius
% Se pretende mejorar el registro con valores de optimización de radio
% inicial, en la memoria se registraron los siguientes valores:
% Radio inicial por defecto = 0.0063
% 0.0043, 0.0023; 0.00010
% Para ver el resultado se debe ir variando el valor y registrarlo 
optimizer.InitialRadius = 0.00010;
tic
registeredRadius = imregister(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',2);
toc 
% Visualización del corte axial 13 del registro con un radio inicial de 0.00010 
figure, imshowpair(registeredRadius(:,:,13), Volume_fixed(:,:,13)); title('Radio inicial de 0.00010 ')
%% Evaluación de los registros modificando el radio inicial
jointHistogram_registeredRadius = vaem_joint_histogram (registeredRadius, Volume_fixed);
figure, imshow (jointHistogram_registeredRadius), title('Hiatograma conjunto radio inicial 0.00010')
jointEntropy_registeredRadius = vaem_joint_entropy (registeredRadius,Volume_fixed);
Entropy_registeredRadius_A = vaem_entropy(registeredRadius);
Entropy_registeredRadius_B = vaem_entropy(Volume_fixed);
mutualInformation_registeredRadius = Entropy_registeredRadius_A + Entropy_registeredRadius_B - jointEntropy_registeredRadius;
%% Rigid Transformation MaximunIterations
% Se pretende mejorar el registro variando el número de iteraciones
% Las iteraciones guardadas en la memoria fueron:
% Valor por defecto = 100
% 200, 400 y 600 iteraciones
optimizer.MaximumIterations = 400;
tic
registeredIteractions = imregister(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',2);
toc
% Visualización del corte axial 12 del registro rígido con 400 iteraciones
% y el registro original con 100 iteraciones por defecto.
figure, subplot(1,2,1); imshowpair(registeredIteractions(:,:,12), Volume_fixed(:,:,12)); title('Registro 400 Iteraciones')
subplot(1,2,2); imshowpair(movingRegisteredVolume1(:,:,12), Volume_fixed(:,:,12)); title('Registro 100 Iteraciones (por defecto)')
%% Evaluación de los registros modificando el número de iteraciones
jointHistogram_registeredIteractions = vaem_joint_histogram (registeredIteractions, Volume_fixed);
figure, imshow (jointHistogram_registeredIteractions), title('Histograma conjunto registro con 400 Iteraciones')
jointEntropy_registeredIteractions = vaem_joint_entropy (registeredIteractions,Volume_fixed);
Entropy_registeredIteractions_A = vaem_entropy(registeredIteractions);
Entropy_registeredIteractions_B = vaem_entropy(Volume_fixed);
mutualInformation_registeredIteractions = Entropy_registeredIteractions_A + Entropy_registeredIteractions_B - jointEntropy_registeredIteractions;
%% Mejoramiento del registro extrayendo la matriz de transformación
% Lo que se pretende es a partir de una matriz de transformación inicial
% realizar otro registro. En este caso se extrajo la matriz de
% transformación rígida y se utilizó como transformación inicial en el 
%registro con un tipo de transformación affine 
geomtformA = imregtform(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'rigid', optimizer, metric,'PyramidLevels',1);
% Registro realizado con la matriz de transformación inicial y una
% transformación affine.
tic
movingRegisteredI = imregister(Volume_moving,Rmoving,Volume_fixed,Rfixed, 'affine', optimizer, metric,'InitialTransformation',geomtformA,'PyramidLevels',1);
toc
%% Evaluación del registro extrayendo la matriz de transformación rígida
jointHistogram_movingRegisteredI = vaem_joint_histogram (movingRegisteredI, Volume_fixed);
figure, imshow (jointHistogram_movingRegisteredI), title('Histograma Conjunto Matriz Transformación rígida + affine')
jointEntropy_movingRegisteredI = vaem_joint_entropy (movingRegisteredI,Volume_fixed);
Entropy_movingRegisteredI_A = vaem_entropy(movingRegisteredI);
Entropy_movingRegisteredI_B = vaem_entropy(Volume_fixed);
mutualInformation_movingRegisteredI = Entropy_movingRegisteredI_A + Entropy_movingRegisteredI_B - jointEntropy_movingRegisteredI;
%% Visualización del registro
figure, subplot (1,3,1),imshowpair(movingRegisteredI(:,:,13),Volume_fixed(:,:,13)); title('#13')
subplot (1,3,2),imshowpair(movingRegisteredI(:,:,10),Volume_fixed(:,:,10)); title('#10')
subplot (1,3,3),imshowpair(movingRegisteredI(:,:,centerFixed(3)), Volume_fixed(:,:,centerFixed(3))); title('Volume Center')
%% PART 2 – 3D registration with known transformation 
% En esta sección se encuentra el código de la segunda parte del proyecto
% final
close all 
clear
%%
% Lectura del volumen TC elegido para este segundo apartado
FixedHeader = helperReadHeaderRIRE('./VolumeData1/pac002CT.header'); %pac00CT fixedImage
Vol_size_F = [FixedHeader.Rows, FixedHeader.Columns, FixedHeader.Slices]; %Get information image
Volume_fixed = multibandread('./VolumeData1/pac002CT.bin', Vol_size_F, 'int16=>int16', 0, 'bsq', 'ieee-be' ); %  to read the binary files that contain image dataa
V1 = Volume_fixed;
[optimizer,metric] = imregconfig('monomodal'); % creates optimizer and metric configurations that we pass to imregister.
%% Creación de la matriz 
% Se crea la matriz de transformación para ser aplicada a V1
%Rotation 30º
T = [cos(pi/6) -sin(pi/6) 0 0; sin(pi/6) cos(pi/6) 0 0; 0 0 1 0; 0 0 0 1];
tform = affine3d(T);
V2 = imwarp(V1,tform);
%Visualización de la figura 17 de la segunda parte del proyecto final
figure, imshowpair(V1(:,:,12),V2(:,:,12)); title('Rotation of 30º')
%% affine Transformation
% En esta sección se realiza el registro con 30º
ct_Ref = imref3d(size(V2));
Rfixed = imref3d(size(V1));
tic
V2_Registered = imregister(V2,ct_Ref,V1,Rfixed, 'affine', optimizer, metric, 'PyramidLevels',1);
toc
%% Visualización de los resultados obtenidos del registro affine anterior 
% con una matriz de transformación de 30 grados, figura 19 del proyecto
% final.
figure, imshowpair(V2_Registered(:,:,12),V1(:,:,12)); title('Registration 30 grados + affine')
%% Evaluación de el registro affine con una matriz T de rotación de 30 grados
jointHistogram_v = vaem_joint_histogram (V2_Registered, V1);
figure, imshow (jointHistogram_v), title('Histograma Conjunto affine - 30 grados')
jointEntropy_v = vaem_joint_entropy (V2_Registered,V1);
Entropy_v_A = vaem_entropy(V2_Registered);
Entropy_v_B = vaem_entropy(V1);
mutualInformation_v = Entropy_v_A + Entropy_v_B - jointEntropy_v;
%% Evaluación de métricas adicionales 
% Estas métricas adicionales son: diferencia entre los volúmenes y el 
%coeficiente de correlación 2D para el corte axial 12 del registro
ct_Ref1 = imref3d(size(V2_Registered));
% Matriz de transformación
geomtform = imregtform(V2_Registered,ct_Ref1,V1,Rfixed, 'affine', optimizer, metric, 'PyramidLevels',1);
%Coeficiente de correlación
R = corr2(V1(:,:,12),V2_Registered(:,:,12));
% Diferencia entre los volúmenes 
V1 = im2double(V1);
V2_Registered = im2double(V2_Registered);
I = imsubtract (V1,V2_Registered);
I2 = imabsdiff (V1,V2_Registered); %Diferencia absoluta
% Visualización de las diferencias obtenidas, figura 20 del proyecto final
figure, subplot (1,2,1);imshow(I(:,:,12),[]), title('imsubtract')
subplot(1,2,2);imshow(I2(:,:,12),[]),title('imabsdiff ')
%%
close all 
clear
% Lectura del volumen TC elegido para este segundo apartado
FixedHeader = helperReadHeaderRIRE('./VolumeData1/pac002CT.header'); %pac00CT fixedImage
Vol_size_F = [FixedHeader.Rows, FixedHeader.Columns, FixedHeader.Slices]; %Get information image
Volume_fixed = multibandread('./VolumeData1/pac002CT.bin', Vol_size_F, 'int16=>int16', 0, 'bsq', 'ieee-be' ); %  to read the binary files that contain image dataa
V1 = Volume_fixed;
[optimizer,metric] = imregconfig('monomodal'); % creates optimizer and metric configurations that we pass to imregister.
%% Cambiando ángulo de rotación a 15 grados
% En esta sección se realiza de nuevo el registro aplicando una
% transformación inicial de 15 grados y un tipo de transformación rígida
% para mejorar el registro
%% Creación de la matriz 
% Se crea la matriz de transformación para ser aplicada a V1
%Rotation 15º
T = [cos(pi/12) -sin(pi/12) 0 0; sin(pi/12) cos(pi/12) 0 0; 0 0 1 0; 0 0 0 1];
tform = affine3d(T);
V2 = imwarp(V1,tform);
%Visualización 
figure, imshowpair(V1(:,:,12),V2(:,:,12)); title('Rotation of 15º')
%% rigid Transformation
% En esta sección se realiza el registro con 15º
ct_Ref = imref3d(size(V2));
Rfixed = imref3d(size(V1));
tic
V2_Registered = imregister(V2,ct_Ref,V1,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',1);
toc
%% Visualización de los resultados obtenidos del registro rigid anterior 
% con una matriz de transformación de 30 grados, figura 19 del proyecto
% final.
figure, imshowpair(V2_Registered(:,:,12),V1(:,:,12)); title('Registration 15 grados + rigid')
%% Evaluación de el registro affine con una matriz T de rotación de 15 grados
jointHistogram_v = vaem_joint_histogram (V2_Registered, V1);
figure, imshow (jointHistogram_v), title('Histograma Conjunto rigid - 15 grados')
jointEntropy_v = vaem_joint_entropy (V2_Registered,V1);
Entropy_v_A = vaem_entropy(V2_Registered);
Entropy_v_B = vaem_entropy(V1);
mutualInformation_v = Entropy_v_A + Entropy_v_B - jointEntropy_v;
%% Evaluación de métricas adicionales 
% Estas métricas adicionales son: diferencia entre los volúmenes y el 
%coeficiente de correlación 2D para el corte axial 12 del registro
ct_Ref1 = imref3d(size(V2_Registered));
% Matriz de transformación
geomtform = imregtform(V2_Registered,ct_Ref1,V1,Rfixed, 'rigid', optimizer, metric, 'PyramidLevels',1);
%Coeficiente de correlación
R = corr2(V1(:,:,12),V2_Registered(:,:,12));
% Diferencia entre los volúmenes 
V1 = im2double(V1);
V2_Registered = im2double(V2_Registered);
I = imsubtract (V1,V2_Registered);
I2 = imabsdiff (V1,V2_Registered); %Diferencia absoluta
% Visualización de las diferencias obtenidas, figura 24 del proyecto final
figure, subplot (1,2,1);imshow(I(:,:,12),[]), title('imsubtract')
subplot(1,2,2);imshow(I2(:,:,12),[]),title('imabsdiff ')
%%
% figure, imshowpair(squeeze(V2_Registered(2,:,:)),squeeze(V1(2,:,:)))