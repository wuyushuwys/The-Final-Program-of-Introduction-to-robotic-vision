%Initiate
% clc;clear all;
% Loading two images
im1 = imread( 'position_1.jpg');
im2 = imread( 'position_2.jpg');
% compressing the images
im1 = imresize( im1, 0.2);
im2 = imresize( im2, 0.2);
% turn RGB images into gray images
im1 = rgb2gray( im1);
im2 = rgb2gray( im2);
% find the feature points
points1 = detectSURFFeatures( im1);
points2 = detectSURFFeatures( im2);
% feature extraction
[features1, validpoints1] = extractFeatures( im1, points1);
[features2, validpoints2] = extractFeatures( im2, points2);
%feature correspondence
indexPairs = matchFeatures(features1, features2, 'Prenormalized', true) ;  
matched_points1 = validpoints1(indexPairs(:, 1));
matched_points2 = validpoints2(indexPairs(:, 2)); 
% show the result
figure('name','correspondence'); 
showMatchedFeatures( im1, im2, matched_points1,matched_points2,'montage');  
legend( 'matched points 1', 'matched points 2');