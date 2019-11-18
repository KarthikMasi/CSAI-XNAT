function antsreg()

raw = '/INPUTS';
results = '/OUTPUTS';

% fixed=directory where atlas is stored
% flabel=directory where atlas labels are stored
fixed='MDA_Atlas_Data/Data/MAP2006.t2avg_rorient.nii';
flabel='MDA_Atlas_Data/Data/MDA2006.label_rorient.nii';

% Create results folder if doesn't exist
mkdir(results)

% Input file must be in .nii or .nii.gz format

% Obtain list of brain ids
draw=dir(raw);
drawlist=cell(length(draw)-2,1);
for ii=3:length(draw)
    tmp=strsplit(draw(ii).name,'_');
    drawlist{ii-2}=tmp{1};
end
brain_idx=unique(drawlist);


%% Loop through all brains

% For each brain:
% 1) Evaluate brain morphology by registering atlas to HRANAT
% 2) Register 50um isotropic HRANAT to atlas image
% 3) Register all parameter maps based on 50um image transformation
for ii=1:length(brain_idx)
    
    %% ANTS Registration Morphometry for HRANAT
    moving=[raw '/' brain_idx{ii} '_split_hranat.nii']; % moving image
    
    tag=[results '/' brain_idx{ii} '_morph'];
    warp=[tag '_Reg0InverseWarp.nii.gz']; % nonrigid inverse transformation matrix
    
    affmorph=[results '/' brain_idx{ii} '_aff_morph.nii.gz']; % affine registered output
    afflabel=[results '/' brain_idx{ii} '_afflabel_morph.nii.gz']; % affine registered labels
    afftrans=[results '/' brain_idx{ii} '_aff_morph.mat']; % affine transformation matrix
    nonrig=[results '/' brain_idx{ii} '_nonrigid_morph.nii.gz']; % nonrigid registered output
    nonriglabel=[results '/' brain_idx{ii} '_nonrigidlabel_morph.nii.gz']; % nonrigid registered labels
    
    % Affine registration of fixed/atlas image to hranat image using FLIRT
    system(['flirt -in ' fixed ' -ref ' moving ...
        ' -out ' affmorph ' -omat ' afftrans])
    
    % Warp atlas labels based on transformation matrix of previous step
    system(['flirt -in ' flabel ' -ref ' moving ...
        ' -out ' afflabel ' -applyxfm -init ' afftrans])
    
    % Run script with basic inputs for antsRegistration
    system(['bash antsreg_input.sh ' affmorph ' ' fixed ' ' tag])
    
    % Nonrigid deformation of fixed/atlas image to match hranat image using
    % affine transformation file 'warp'
    system(['bash antstrans.sh ' affmorph ' ' nonrig ' ' moving ' ' warp])
    system(['bash antsmorphlabel.sh ' afflabel ' ' nonriglabel ' ' moving ' ' warp])
    
    
    %% ANTS Affine and Nonrigid Registration of HRANAT
    
    tag=[results '/' brain_idx{ii} '_hranat'];
    warp=[tag '_Reg0Warp.nii.gz']; % nonrigid forward transformation matrix
    
    affout=[results '/' brain_idx{ii} '_aff_hranat.nii.gz']; % affine registered output
    afftrans=[results '/' brain_idx{ii} '_aff_hranat.mat']; % affine transformation matrix
    nonrig=[results '/' brain_idx{ii} '_nonrigid_hranat.nii.gz']; % nonrigid registered output
    
    % Affine registration of hranat image to fixed/atlas image using FLIRT
    system(['flirt -in ' moving ' -ref ' fixed ...
        ' -out ' affout ' -omat ' afftrans])
    
    % Run script with basic inputs for antsRegistration
    system(['bash antsreg_input.sh ' fixed ' ' affout ' ' tag])
    
    % Nonrigid deformation of hranat image to match fixed/atlas image using
    % transformation file 'warp'
    system(['bash antstrans.sh ' affout ' ' nonrig ' ' fixed ' ' warp])
    
    %% ANTS Affine and Nonrigid Registration of parameter maps
    
    for jj=3:length(draw)
        % Any file containing brain id label and is not 'hranat' is a 
        % parameter map, register these maps
        if contains(draw(jj).name,brain_idx{ii}) && ~contains(draw(jj).name,'hranat')
            moving=[raw '/' draw(jj).name]; % name of parameter map file
            [P F E]=fileparts(moving);
            tmp=strsplit(F,'_');
            mapname=tmp{end}; % get the type of parameter map from the file name
            
            affout=[results '/' brain_idx{ii} '_aff_' mapname '.nii.gz']; % affine registered output
            nonrig=[results '/' brain_idx{ii} '_nonrigid_' mapname '.nii.gz']; % nonrigid registered output
            
            % Affine registration of parameter map to fixed/atlas image using FLIRT
            system(['flirt -in ' moving ' -ref ' fixed ...
                ' -out ' affout ' -applyxfm -init ' afftrans])
            
            % Nonrigid deformation of parameter map to fixed/atlas image using
            % transformation file 'warp'
            system(['bash antstrans.sh ' affout ' ' nonrig ' ' fixed ' ' warp])
        else
            % Do nothing if 'else'
        end
    end
    
end

