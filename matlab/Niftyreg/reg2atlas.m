function reg2atlas(results,atlasdir)
% Registers all images in results/Interp/mat folder to a reference brain
% specified in atlasdir

%% Register images

% Full Directory containing Atlas
% atlasdir='/data/kim/REMMI_Test/process_code/Atlas/mat/ReferenceBrainImage.mat';

% Directory containing interpolated data
interpmat=fullfile(results,'Interp','mat');

% Directory to save
regmat=fullfile(results,'Registered','mat');
regnii=fullfile(results,'Registered','nii');

% Create save directory for individual data
mkdir(fullfile(results,'Registered'))
mkdir(fullfile(results,'Registered','mat'))
mkdir(fullfile(results,'Registered','nii'))

% Register data in /results/Interp/mat
files1=dir(interpmat);

% Reference image to register data to
ref=abs(cell2mat(struct2cell(load(atlasdir))));

% Register HRANAT data to atlas

% Loop through each file in specified directory 
% Iteration counter starts at 3 because first two are '.' and '..'
for ii=3:length(files1)
    filenames1=files1(ii).name;
    
    % Only register HRANAT images
    if contains(filenames1,'hranat')
        
        % Obtain labels for saving data later
        chk=strsplit(filenames1,'_');
        
        % Image to register
        flo=abs(cell2mat(struct2cell(load(fullfile(interpmat,filenames1)))));
        
        % Full path to save control points/transformation matrix 
        % Must be in .nii data format
        cppath=fullfile(regmat,[chk{1} '_reg_hranat_cpp.nii']);
        
        % Call registration script
        [out,~]=niftyreg(ref,flo,regnii,cppath);
        
        % Save out data in .mat and .nii format with appropriate labels
        save(fullfile(regmat,[chk{1} '_reg_hranat.mat']),'out')
        niftiwrite(out,fullfile(regnii,[chk{1} '_reg_hranat.nii']))
    end
end

% Register/resample parameter maps using transformation matrix defined
% from previous step (registering HRANAT images to atlas)

% Loop through each file in specified directory 
% Iteration counter starts at 3 because first two are '.' and '..'
for ii=3:length(files1)
    filenames1=files1(ii).name;
    
    % Only register parameter maps (images that are not 'HRANAT')
    if ~contains(filenames1,'hranat')
        
        % Obtain labels for saving data later
        chk=strsplit(filenames1,'_');
        
        % Image to register
        flo=abs(cell2mat(struct2cell(load(fullfile(interpmat,filenames1)))));
        
        % Full path to control points/transformation matrix 
        % Must be in .nii data format
        cppath=fullfile(regmat,[chk{1} '_reg_hranat_cpp.nii']);
        
        % Call registration script with 'resample' option
        [out,~]=niftyreg(ref,flo,regnii,cppath,'resample');
        
        % Save out data in .mat and .nii format with appropriate labels
        save(fullfile(regmat,[chk{1} '_reg_' chk{end}]),'out')
        niftiwrite(out,fullfile(regnii,[chk{1} '_reg_' chk{end}]))
    end
end