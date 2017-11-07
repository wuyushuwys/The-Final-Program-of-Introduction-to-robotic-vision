% % Initiate the programe
clc;clear all;
calib_loading;

% Loading the two images and resize them
im1 = imread( 'position_1.jpg');
im2 = imread( 'position_2.jpg');
% compressing the images
im1 = imresize( im1, 0.3);
im2 = imresize( im2, 0.3);
% turn RGB images into gray images
im1 = rgb2gray( im1);
im2 = rgb2gray( im2);

% % Using the SURF to extract the feature points
sf1 = isurf( im1);
sf2 = isurf( im2);
m = sf1.match(sf2);
F = m.ransac(@fmatrix, 1e-5, 'verbose');

% Show the matched points
idisp({im1, im2});
m.inlier.subset(20).plot('g');

% Calculate the Fundamental Matrix and the Essential Matrix
FundamentalMatrix;
K = cameraParams.IntrinsicMatrix;
EssentialMatrix = K * F * K';

%Output the solution
[s] = CalculateSolution( EssentialMatrix);
Vector_1 = s(1)
Vector_2 = s(2)