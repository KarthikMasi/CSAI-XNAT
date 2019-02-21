%% Example of how to use registration script
% Section 1: Registration of a floating image to reference image
% Section 2: Use predefined transformation matrix to register image

%% Input

% Full path to reference image
atlaspath='/data/kim/REMMI_Test/process_code/Atlas/mat/ReferenceBrainImage.mat';

% Directory to store registration output
regdir='/data/kim/REMMI_Test/reg';

% Register data in 'sample' (use full path)
data=load(fullfile(regdir,'sample.mat'));

% Reference image to register data to
ref=abs(cell2mat(struct2cell(load(atlaspath))));

%% Section 1: Register data to reference
       
% Image to register
flo=data.img;

% Note: For ideal registration, reference and floating images should be same
% matrix size. Input resolution of floating image.
flo=remmi_interp(flo,[.15 .15 .15]);

% Full path to save control points/transformation matrix
% Must be in .nii data format
cppath=fullfile(regdir,'cpp.nii');

% Call registration script
% out1 is registered image, cpp1 is associated control points
[out1,cpp1]=niftyreg(ref,flo,regdir,cppath);        

%% Section 2: Register/resample data using transformation matrix defined previously
        
% Image to register
flo=data.img2;

% Note: For ideal registration, reference and floating images should be same
% matrix size. Input resolution of floating image.
flo=remmi_interp(flo,[.15 .15 .15]);

% Full path to control points/transformation matrix
% Must be in .nii data format
cppath=fullfile(regdir,'cpp.nii');

% Call registration script with 'resample' option
% out2 is registered image, cpp2 is associated control points
[out2,cpp2]=niftyreg(ref,flo,regdir,cppath,'resample');

       