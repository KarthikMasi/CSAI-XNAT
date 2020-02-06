function antsreg()

raw = '/INPUTS';
results = '/OUTPUTS';

% fixed=directory where atlas is stored
% flabel=directory where atlas labels are stored
fixed='/extra/MDA_Atlas_Data/Data/MAP2006.t2avg_rorient.nii';
flabel='/extra/MDA_Atlas_Data/Data/MDA2006.label_rorient.nii';

% Create results folder if doesn't exist
mkdir(results)

% Input file must be in .nii or .nii.gz format

% Obtain list of input directory contents
draw=dir(raw);

%% Loop through all brains

% For each brain:
% 1) Evaluate brain morphology by registering atlas to HRANAT
% 2) Register 50um isotropic HRANAT to atlas image
% 3) Register all parameter maps based on 50um image transformation


%% ANTS Registration Morphometry for HRANAT
moving=[raw '/split_hranat.nii.gz']; % moving image

tag=[results '/morph'];
warp=[tag '_Reg0InverseWarp.nii.gz']; % nonrigid inverse transformation matrix

affmorph=[results '/aff_morph.nii.gz']; % affine registered output
afflabel=[results '/afflabel_morph.nii.gz']; % affine registered labels
afftrans=[results '/aff_morph.mat']; % affine transformation matrix
nonrig=[results '/nonrigid_morph.nii.gz']; % nonrigid registered output
nonriglabel=[results '/nonrigidlabel_morph.nii.gz']; % nonrigid registered labels

% Affine registration of fixed/atlas image to hranat image using FLIRT
system(['flirt -in ' fixed ' -ref ' moving ...
    ' -out ' affmorph ' -omat ' afftrans])

% Warp atlas labels based on transformation matrix of previous step
system(['flirt -in ' flabel ' -ref ' moving ...
    ' -out ' afflabel ' -applyxfm -init ' afftrans])

% Run script with basic inputs for antsRegistration
system(['bash /extra/antsreg_input.sh ' affmorph ' ' fixed ' ' tag])

% Nonrigid deformation of fixed/atlas image to match hranat image using
% affine transformation file 'warp'
system(['bash /extra/antstrans.sh ' affmorph ' ' nonrig ' ' moving ' ' warp])
system(['bash /extra/antsmorphlabel.sh ' afflabel ' ' nonriglabel ' ' moving ' ' warp])


%% ANTS Affine and Nonrigid Registration of HRANAT

tag=[results '/hranat'];
warp=[tag '_Reg0Warp.nii.gz']; % nonrigid forward transformation matrix

affout=[results '/aff_hranat.nii.gz']; % affine registered output
afftrans=[results '/aff_hranat.mat']; % affine transformation matrix
nonrig=[results '/nonrigid_hranat.nii.gz']; % nonrigid registered output

% Affine registration of hranat image to fixed/atlas image using FLIRT
system(['flirt -in ' moving ' -ref ' fixed ...
    ' -out ' affout ' -omat ' afftrans])

% Run script with basic inputs for antsRegistration
system(['bash /extra/antsreg_input.sh ' fixed ' ' affout ' ' tag])

% Nonrigid deformation of hranat image to match fixed/atlas image using
% transformation file 'warp'
system(['bash /extra/antstrans.sh ' affout ' ' nonrig ' ' fixed ' ' warp])

%% ANTS Affine and Nonrigid Registration of parameter maps

for jj=3:length(draw)
    % Any file containing brain id label and is not 'hranat' is a
    % parameter map, register these maps
    if ~contains(draw(jj).name,'hranat')
        moving=[raw '/' draw(jj).name]; % name of parameter map file
        [~,Ftmp,~]=fileparts(moving);
        [~,F,~]=fileparts(Ftmp);
        tmp=strsplit(F,'_');
        mapname=tmp{end}; % get the type of parameter map from the file name
        
        affout=[results '/aff_' mapname '.nii.gz']; % affine registered output
        nonrig=[results '/nonrigid_' mapname '.nii.gz']; % nonrigid registered output
        
        % Affine registration of parameter map to fixed/atlas image using FLIRT
        system(['flirt -in ' moving ' -ref ' fixed ...
            ' -out ' affout ' -applyxfm -init ' afftrans])
        
        % Nonrigid deformation of parameter map to fixed/atlas image using
        % transformation file 'warp'
        system(['bash /extra/antstrans.sh ' affout ' ' nonrig ' ' fixed ' ' warp])
    else
        % Do nothing if 'else'
    end
end
orgoutput(results)