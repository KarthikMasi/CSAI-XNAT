function process(raw,results)
addpath('Denoise')
addpath('NIFTI')

%% Process Raw Scan Data
process_scan(raw,results)

% Load in textfile with input parameters
fid = fopen(fullfile(raw,'process_input.txt'),'r');
if fid == -1
    sprintf('Error: Could not open method file');
end

% Load text into cell array M
% M{1}=variable names
% M{2}=variable values
M = textscan(fid,'%s %s',...
'Delimiter','=');

% Extract brain identifiers from text file
tmp=M{2}{4};
tmp2=strsplit(tmp,','); % Separate elements with comma delimeter
brain_idx=string(cellfun(@(c) erase({c},' '),tmp2)); % Remove extra spaces if any

%% Split Multibrain dataset into Individual datasets

% Directory to save
splitmat=fullfile(results,'Split_Data','mat');
splitnii=fullfile(results,'Split_Data','nii');

% Create save directory for individual data
mkdir(fullfile(results,'Split_Data'));
mkdir(fullfile(results,'Split_Data','mat'));
mkdir(fullfile(results,'Split_Data','nii'));


% Split rawimg data and obtain coordinates to split remaining data
tmp=load(fullfile(results,'Parameter_Maps','rawimg.mat'));
img=abs(cell2mat(struct2cell(tmp)));
out=splitn(img,length(brain_idx));
coords=out.coords;
for ii=1:length(brain_idx)
    segimg=out.segimg{ii};
    save(fullfile(splitmat,[char(brain_idx(ii)) '_split_' 'rawimg.mat']),'segimg')
end

% Use coordinates to split remaining data in /results/Parameter_Maps
files1=dir(fullfile(results,'Parameter_Maps'));

for ii=3:length(files1)
    filenames1=files1(ii).name;
    if ~strcmp(filenames1,'rawimg.mat') && ~strcmp(filenames1,'hranat.mat')
        tmp=load(fullfile(results,'Parameter_Maps',filenames1));
        img=abs(cell2mat(struct2cell(tmp)));
        out=splitn(img,length(brain_idx),coords);
        for jj=1:length(brain_idx)
            segimg=out.segimg{jj};
            name1=strrep(filenames1,'.mat','');
            save(fullfile(splitmat,[char(brain_idx(jj)) '_split_' name1]),'segimg')
        end
    end
end

% Relevant image files are stored in /results/Parameter_Maps
% Read data from that folder
tmp=load(fullfile(results,'Parameter_Maps','hranat.mat'));
img=abs(cell2mat(struct2cell(tmp)));

% Split HRANAT data

% HRANAT generally has higher spatial resolution than the other parameter
% maps
% To find the coordinates used to split HRANAT data, multiply coords by
% the factor of how much higher the HRANAT spatial resolution is

tmp=load(fullfile(results,'Full_Data','hranat.mat'));
res1=tmp.images.pars.methpars.PVM_SpatResol;

tmp=load(fullfile(results,'Full_Data','sir.mat'));
res2=tmp.images.pars.methpars.PVM_SpatResol;

out=splitn(img,length(brain_idx),int16(coords*(res2(1)/res1(1))));
for ii=1:length(brain_idx)
    segimg=out.segimg{ii};
    save(fullfile(splitmat,[char(brain_idx(ii)) '_split_' 'hranat.mat']),'segimg')
end

%% Reorient all data in Split_Data folder to reflect true anatomical LPS
 % orientation
files1=dir(splitmat);

for ii=3:length(files1)
    filenames1=files1(ii).name;
    name1=strrep(filenames1,'.mat','');
    tmp=load(fullfile(splitmat,filenames1));
    img=abs(cell2mat(struct2cell(tmp)));
    
    out=reorient(img);
    save(fullfile(splitmat,filenames1),'out');
    
    niftiwrite(out,fullfile(splitnii,[name1 '.nii']))
    if contains(filenames1,'hranat')
        tmp=load(fullfile(results,'Full_Data','hranat.mat'));
        voxdim=tmp.images.pars.methpars.PVM_SpatResol;
    else
        tmp=load(fullfile(results,'Full_Data','sir.mat'));
        voxdim=tmp.images.pars.methpars.PVM_SpatResol;
    end
    
    % Correct NIFTI header info
    hdrinfo(fullfile(splitnii,[name1 '.nii']),voxdim);
end