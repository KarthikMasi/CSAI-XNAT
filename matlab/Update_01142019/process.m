function process(raw,results)

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

% Relevant image files are stored in /results/Parameter_Maps/mat
% Read data from that folder
tmp=load(fullfile(results,'Parameter_Maps','mat','hranat.mat'));
img=abs(cell2mat(struct2cell(tmp)));

% Split HRANAT data
out=splitn(img,length(brain_idx));
for ii=1:length(brain_idx)
    segimg=out.segimg{ii};
    save(fullfile(splitmat,[char(brain_idx(ii)) '_split_' 'hranat.mat']),'segimg')
    segimg_nii=make_nii(segimg);
    save_nii(segimg_nii,fullfile(splitnii,[char(brain_idx(ii)) '_split_' 'hranat.nii']));
end

% Split rawimg data and obtain coordinates to split remaining data
tmp=load(fullfile(results,'Parameter_Maps','mat','rawimg.mat'));
img=abs(cell2mat(struct2cell(tmp)));
out=splitn(img,length(brain_idx));
coords=out.coords;
for ii=1:length(brain_idx)
    segimg=out.segimg{ii};
    save(fullfile(splitmat,[char(brain_idx(ii)) '_split_' 'rawimg.mat']),'segimg')
    segimg_nii=make_nii(segimg);
    save_nii(segimg_nii,fullfile(splitnii,[char(brain_idx(ii)) '_split_' 'rawimg.nii']));
end

% Use coordinates to split remaining data in /results/Parameter_Maps/mat
files1=dir(fullfile(results,'Parameter_Maps','mat'));

for ii=3:length(files1)
    filenames1=files1(ii).name;
    tmp=load(fullfile(results,'Parameter_Maps','mat',filenames1));
    img=abs(cell2mat(struct2cell(tmp)));
    if ~strcmp(filenames1,'rawimg.mat') && ~strcmp(filenames1,'hranat.mat')
        out=splitn(img,length(brain_idx),coords);
        for jj=1:length(brain_idx)
            segimg=out.segimg{jj};
            name1=strrep(filenames1,'.mat','');
            save(fullfile(splitmat,[char(brain_idx(jj)) '_split_' name1]),'segimg')
            segimg_nii=make_nii(segimg);
            save_nii(segimg_nii,fullfile(splitnii,...
                [char(brain_idx(jj)) '_split_' name1]));
        end
    end
end

%% Interpolate each dataset to same resolution as Atlas

% Directory to save
interpmat=fullfile(results,'Interp','mat');
interpnii=fullfile(results,'Interp','nii');

% Create save directory for individual data
mkdir(fullfile(results,'Interp'));
mkdir(fullfile(results,'Interp','mat'));
mkdir(fullfile(results,'Interp','nii'));

% Interpolate data in /results/Parameter_Maps/mat
files1=dir(fullfile(results,'Split_Data','mat'));

for ii=3:length(files1)
    filenames1=files1(ii).name;
    tmp=load(fullfile(results,'Split_Data','mat',filenames1));
    img=abs(cell2mat(struct2cell(tmp)));
    
    % If HRANAT, use resolution of .05mm isotropic,
    % otherwise use .15mm for the other scans
    chk=strsplit(filenames1,'_');
    chk2=strrep(chk{end},'.mat','');
    if strcmp(chk2,'hranat')
        out=remmi_interp(img,[.05 .05 .05]);
    else
        out=remmi_interp(img,[.15 .15 .15]);
    end
    
    name1=strrep(filenames1,'split','interp');
    save(fullfile(interpmat,name1),'out')
    interp_nii=make_nii(out);
    save_nii(interp_nii,fullfile(interpnii,name1));
end