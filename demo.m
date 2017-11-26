% % This demo edited by Yushu Wu 05-NOV-2017
% % Initiate the programe
% % You can download RVCTOOL both robotic and vision toolboxs from peter-corke's official website.


% % =================================================================================
% % Checking previous work, if IntrinsicMatrix has been calculated then
% jump into next step
% function [Vector_1, Vector_2] = demo
if(~exist('cameraParams','var'))
    % initial
    clc;clear all;

    % detecting the IntrinsicMatrix of camera
    % this process could be very slow, if your calib pictures are very large.
    calib_loading;
else
    clc;
end
% Loading the two images and resize them
im1 = imread( 'position_1.jpg');
im2 = imread( 'position_2.jpg');
% compressing the images. if needed, you can change the value to modify your model. 
im1 = imresize( im1, 0.5);
im2 = imresize( im2, 0.5);
% turn RGB images into gray images
im1 = rgb2gray( im1);
im2 = rgb2gray( im2);

% % Using the SURF to extract the feature points
% % any bugs in this part, you should check whether your rvctools have been installed completed.
sf1 = isurf( im1);
sf2 = isurf( im2);
m = sf1.match(sf2);
% if the matching results are not satisfied, you could change the value '1e-4' in ransac.
F = m.ransac(@fmatrix, 1e-5, 'verbose');

% % Show the matched points
% % any bugs in this part, you should check whether your rvctools have been installed completed.
idisp({im1, im2});
m.inlier.subset(30).plot('g');

% Calculate the Fundamental Matrix and the Essential Matrix
FundamentalMatrix;
K = cameraParams.IntrinsicMatrix;
EssentialMatrix = K * F * K';

%Output the solution
[s] = CalculateSolution( EssentialMatrix);

%find the true solution
Vector_1 = double(s(1));
Vector_2 = double(s(2));
test_position = [0 0 10 1]'; %a distant point along the optical axis
temp_1 = Vector_1 * test_position;
temp_2 = Vector_2 * test_position;
temp = [temp_1(3), temp_2(3)];
fprintf('the answer is\n');
if temp(1)>0
   disp(Vector_1)
else
   disp(Vector_2)
end

% end