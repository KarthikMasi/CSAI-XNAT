function process(raw,results)

% DKK REDCap API Token Key
apikey='27A46C631F1B95667CFEC4A907108ADB';

% Subject ID in REDCap, should be same as raw scan data folder
[P F E]=fileparts(raw);
subjectid=F;

% Run python script to generate input text file for processing scan data
system(['python3 generate_input_info.py -k ' apikey ' -s ' subjectid ' -f ' raw '/process_input.txt'])
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

% Split HRANAT data
% Relevant image files are stored in /results/Parameter_Maps
% Read data from that folder
tmp=load(fullfile(results,'Parameter_Maps','hranat.mat'));
img=abs(cell2mat(struct2cell(tmp)));

out=splitn(img,length(brain_idx));
coords=zeros(size(out.coords));

% Coordinates for splitting must be integers
coords(:,[1 3])=3*floor(out.coords/3); % Floor minx and miny coords
coords(:,[2 4])=3*ceil(out.coords/3);  % Ceil maxx and maxy coords

coords(coords<3)=1; % minx and miny coords cannot be less than 1

tmp=coords(:,2);
tmp(tmp>size(img,1))=size(img,1); % maxx coord threshold
coords(:,2)=tmp;

tmp=coords(:,4);
tmp(tmp>size(img,2))=size(img,2); % maxy coord threshold
coords(:,4)=tmp;

out=splitn(img,length(brain_idx),coords);
for ii=1:length(brain_idx)
    segimg=out.segimg{ii};
    save(fullfile(splitmat,[char(brain_idx(ii)) '_split_' 'hranat.mat']),'segimg')
end

% Use coordinates to split remaining data in /results/Parameter_Maps
files1=dir(fullfile(results,'Parameter_Maps'));

coords=ceil(coords/3); % Parameter map data is 1/3 image size of HRANAT
for ii=3:length(files1)
    filenames1=files1(ii).name;
    if ~strcmp(filenames1,'hranat.mat')
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



%% Reorient all data in Split_Data folder to reflect true anatomical LPS
 % orientation
files1=dir(splitmat);

tmp=load(fullfile(results,'Full_Data','hranat.mat'));
voxdim=tmp.images.pars.methpars.PVM_SpatResol;

for ii=3:length(files1)
    filenames1=files1(ii).name;
    name1=strrep(filenames1,'.mat','');
    tmp=load(fullfile(splitmat,filenames1));
    img=abs(cell2mat(struct2cell(tmp)));
    
    % Resize parameter maps to match hranat resolution
    if ~contains(filenames1,'hranat')
        img=imresize3(img,3);
    end
    
    out=reorient(img);
    save(fullfile(splitmat,filenames1),'out');
    
    niftiwrite(out,fullfile(splitnii,[name1 '.nii']))
    
    % Correct NIFTI header info
    hdrinfo(fullfile(splitnii,[name1 '.nii']),voxdim);
end