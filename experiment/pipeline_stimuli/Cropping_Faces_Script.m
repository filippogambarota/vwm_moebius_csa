%%% SCRIPT CROPPING FACES
%%% Filippo Gambarota

clear

% Which emotion?

Gender = "Female";
Emotion = "Anger";

% Cropping values

x = 37;
y = 33;
w = 241;
h = 312;

% Reading all 8 images

fullfile('C','User','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','0.png');

im0 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','0.png'));
im1 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','1.png'));
im2 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','2.png'));
im3 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','3.png'));
im4 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','4.png'));
im5 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','5.png'));
im6 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','6.png'));
im7 = imread(fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','7.png'));

% Loading the previous created MASK

imshow(im0); %needed to use imellipse
ellipse = imellipse(gca,[x y w h]); % creates user defined ellipse object.
MASK = double(ellipse.createMask());
close

% image to grayscale

im0 = rgb2gray(im0);
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
im3 = rgb2gray(im3);
im4 = rgb2gray(im4);
im5 = rgb2gray(im5);
im6 = rgb2gray(im6);
im7 = rgb2gray(im7);

% Cropping and Saving images

imwrite(im0, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','0.png'),"png", "Alpha",MASK);
imwrite(im1, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','1.png'),"png", "Alpha",MASK);
imwrite(im2, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','2.png'),"png", "Alpha",MASK);
imwrite(im3, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','3.png'),"png", "Alpha",MASK);
imwrite(im4, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','4.png'),"png", "Alpha",MASK);
imwrite(im5, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','5.png'),"png", "Alpha",MASK);
imwrite(im6, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','6.png'),"png", "Alpha",MASK);
imwrite(im7, fullfile('C:','Users','Filippo','Desktop','Stimuli',Emotion,Gender,'Pictures','Selection','Cropped','Final','7.png'),"png", "Alpha",MASK);