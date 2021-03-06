% Auto-generated by cameraCalibrator app on 07-Nov-2017
%-------------------------------------------------------
% in this part you need to rerun the calibrator app and change some details in the progame below.
 
% Define images to process
imageFileNames = {'G:\robot\Final test\calib\calib (1).JPG',...
    'G:\robot\Final test\calib\calib (2).JPG',...
    'G:\robot\Final test\calib\calib (3).JPG',...
    'G:\robot\Final test\calib\calib (4).JPG',...
    'G:\robot\Final test\calib\calib (5).JPG',...
    'G:\robot\Final test\calib\calib (6).JPG',...
    'G:\robot\Final test\calib\calib (7).JPG',...
    'G:\robot\Final test\calib\calib (8).JPG',...
    'G:\robot\Final test\calib\calib (9).JPG',...
    'G:\robot\Final test\calib\calib (10).JPG',...
    'G:\robot\Final test\calib\calib (11).JPG',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 11;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
cameraParams = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', true, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm');

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams, 'BarGraph');

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% For example, you can use the calibration data to remove effects of lens distortion.
originalImage = imread(imageFileNames{1});
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('SparseReconstructionExample')
