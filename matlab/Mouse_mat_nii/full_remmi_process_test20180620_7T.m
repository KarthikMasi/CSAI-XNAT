function full_remmi_process_test20180620_7T(raw,results)
%close all
%clear all
%clc
addpath('/data/mcr/masimatlab/trunk/xnatspiders/matlab/Mouse_mat_nii')
% 7T, 25mm coil, WT1352,WT1354,PSEN1361,PSEN1351 (clockwise from top left)
%filename='20180620_101757_MB4_DKK_7_WT1352_1_1';

% List the study path and experiments to process
info.spath = fullfile(raw)

% Directory to save
savdir = fullfile(results)

% Create image save directories
if ~isdir(fullfile(savdir,'NIFTI'))    
    mkdir(fullfile(savdir,'NIFTI'));
end
if ~isdir(fullfile(savdir,'Images'))    
    mkdir(fullfile(savdir,'Images'));
    mkdir(fullfile(savdir,'Images','Sample_Maps'));
end

%% ANAT
info.exps=4;
ws_anat = remmi.workspace('anat.mat');

% % reconstruct the data
ws_anat.images = remmi.recon(info);

% for ii=1:size(ws_anat.images.img,3)
%     imagesc(abs(squeeze(ws_anat.images.img(:,:,ii,1))))
%     title(['Slice number ' num2str(ii)])
%     waitforbuttonpress
% end
% anat_img_slice=abs(squeeze(ws_anat.images.img(:,:,end/2)));
% snr_anat=remmi.util.snrCalc(anat_img_slice)

movefile('anat.mat',fullfile(savdir,'anat_full.mat'))
%% MSE
info.exps=5;
ws_mse = remmi.workspace('mse.mat');

% Reconstruct the data
ws_mse.images = remmi.recon(info);

% for ii=1:size(ws_mse.images.img,3)
%     imagesc(abs(squeeze(ws_mse.images.img(:,:,ii,1))))
%     title(['Slice number ' num2str(ii)])
%     waitforbuttonpress
% end
% for ii=1:size(ws_mse.images.img,3)
%     imagesc(abs(squeeze(ws_mse.dT2spect.MWF(:,:,ii))))
%     title(['Slice number ' num2str(ii)])
%     waitforbuttonpress
% end
%mse_img_te1=abs(squeeze(ws_mse.images.img(:,:,end/2,1)));
%snr_mse=remmi.util.snrCalc(mse_img_te1)

% Set a threshold mask
ws_mse.images = remmi.util.thresholdmask(ws_mse.images);
dimages = ws_mse.images; % complex denoised

% Size of window
Nv = ceil(size(ws_mse.images.img,4)^(1/3));

% Denoise complex images
[dimages.img,S2,P] = denoiseCV(ws_mse.images.img,[Nv,Nv,Nv],...
    ws_mse.images.mask);
 
% Load denoised images into the remmi workspace, then clear dummies
ws_mse.dimages = dimages;
ws_mse.dnmaps.S2 = S2;
ws_mse.dnmaps.P = P;
clear dimages

% Multi-exponential T2 Analysis using MERA

% Fitting parameters
fitting.B1fit = 'y';
fitting.regtyp = 'mc';
fitting.regweight = 1e-4;
fitting.regadj = 'manual';
fitting.numberT = 60;
fitting.rangeT = [ws_mse.images.pars.te(1)*.75,ws_mse.images.pars.te(end)*4/3];

fitting.rangetheta = [135 180]; % normally use 135,180, but B1 is close to 180
fitting.numbertheta = 10;
analysis.tolextract = 0;

% Specify output metrics
metrics.S = @(out) out.S;
metrics.SNR = @(out) out.SNR;
metrics.Tv = @(out) out.Tv;
metrics.Fv = @(out) out.Fv;
metrics.B1 = @(out) out.theta;
metrics.MWF  = ...
 str2func('@(out) sum(out.Fv.*(out.Tv>0.005 & out.Tv<.027),1)./sum(out.Fv,1)');

tic
ws_mse.T2spect= remmi.mse.mT2(ws_mse.images,metrics,fitting,analysis); %9179s
toc

tic
ws_mse.dT2spect= remmi.mse.mT2(ws_mse.dimages,metrics,fitting,analysis); %9501s
toc

movefile('mse.mat',fullfile(savdir,'mse_full.mat'))

%% SIR
info.exps=6;
ws_sir = remmi.workspace('sir.mat');

% Reconstruct the data
ws_sir.images = remmi.recon(info);

% for ii=1:size(ws_sir.dqMT.BPF,1)
%     imagesc(abs(squeeze(ws_sir.dqMT.BPF(ii,:,:))))
%     title(['Slice number ' num2str(ii)])
%     waitforbuttonpress
% end
% sir_img_longti=abs(squeeze(ws_sir.images.img(:,:,end/2,end)));
% snr_sir=remmi.util.snrCalc(sir_img_longti)

% Set a threshold mask
ws_sir.images = remmi.util.thresholdmask(ws_sir.images);
dimages = ws_sir.images; % complex denoised


% Size of window
Nv = ceil(size(ws_sir.images.img,4)^(1/3));

% Denoise complex images
[dimages.img,S2,P] = denoiseCV(ws_sir.images.img,[Nv,Nv,Nv],...
    ws_sir.images.mask);
 
% Load denoised images into the remmi workspace, then clear dummies
ws_sir.dimages = dimages;
ws_sir.dnmaps.S2 = S2;
ws_sir.dnmaps.P = P;
clear dimages

% Perform qMT analysis
tic
ws_sir.qMT = remmi.ir.qmt(ws_sir.images); % 21794s
toc

tic
ws_sir.dqMT = remmi.ir.qmt(ws_sir.dimages); % 20885s
toc

movefile('sir.mat',fullfile(savdir,'sir_full.mat'))
%% DTI
info.exps=7;
ws_dti = remmi.workspace('dti.mat');

% % reconstruct the data
ws_dti.images = remmi.recon(info);

% for ii=1:size(ws_dti.images.img,3)
%     imagesc(abs(squeeze(ws_dti.ddti.adc(:,:,ii,1))))
%     title(['Slice number ' num2str(ii)])
%     waitforbuttonpress
% end
% dti_img_b0=abs(squeeze(ws_dti.images.img(:,:,end/2,1)));
% snr_dti=remmi.util.snrCalc(dti_img_b0)

% Set a threshold mask
ws_dti.images = remmi.util.thresholdmask(ws_dti.images);
dimages = ws_dti.images; % complex denoised

% Size of window
Nv = ceil(size(ws_dti.images.img,4)^(1/3));

% Denoise complex images
[dimages.img,S2,P] = denoiseCV(ws_dti.images.img,[Nv,Nv,Nv],...
    ws_dti.images.mask);
 
% Load denoised images into the remmi workspace, then clear dummies
ws_dti.dimages = dimages;
ws_dti.dnmaps.S2 = S2;
ws_dti.dnmaps.P = P;
clear dimages

% Perform DTI analysis
tic
ws_dti.dti =remmi.dwi.dti(ws_dti.images); %243s
toc

tic
ws_dti.ddti = remmi.dwi.dti(ws_dti.dimages); %243s
toc

movefile('dti.mat',fullfile(savdir,'dti_full.mat'))

%% Convert to NIFTI
anat_img=ws_anat.images.img;
mwf_map=ws_mse.dT2spect.MWF;
mwf_img=squeeze(abs(ws_mse.images.img(:,:,:,1)));
bpf_map=ws_sir.dqMT.BPF;
bpf_img=squeeze(abs(ws_sir.images.img(:,:,:,end)));
adc_map=ws_dti.ddti.adc;
adc_img=squeeze(abs(ws_dti.images.img(:,:,:,1)));

anat_nii=make_nii(anat_img);
mwf_nii=make_nii(mwf_map);
mwf_img_nii=make_nii(mwf_img);
bpf_nii=make_nii(bpf_map);
bpf_img_nii=make_nii(bpf_img);
adc_nii=make_nii(adc_map);
adc_img_nii=make_nii(adc_img);

save_nii(anat_nii,fullfile(savdir,'anat.nii'));
save_nii(mwf_nii,fullfile(savdir,'mwf.nii'));
save_nii(mwf_img_nii,fullfile(savdir,'mwf_img.nii'));
save_nii(bpf_nii,fullfile(savdir,'bpf.nii'));
save_nii(bpf_img_nii,fullfile(savdir,'bpf_img.nii'));
save_nii(adc_nii,fullfile(savdir,'adc.nii'));
save_nii(adc_img_nii,fullfile(savdir,'adc_img.nii'));

status = movefile(fullfile(savdir,'anat.nii'),fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'mwf.nii'),fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'mwf_img.nii'),fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'bpf.nii'),fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'bpf_img.nii'),fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'adc.nii'),fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'adc_img.nii'),fullfile(savdir,'NIFTI'));

generate_pdf(anat_nii,fullfile(savdir,'NIFTI'),'anat');
generate_pdf(mwf_nii,fullfile(savdir,'NIFTI'),'mwf');
generate_pdf(mwf_img_nii,fullfile(savdir,'NIFTI'),'mwf_img');
generate_pdf(bpf_nii,fullfile(savdir,'NIFTI'),'bpf');
generate_pdf(bpf_img_nii,fullfile(savdir,'NIFTI'),'bpf_img');
generate_pdf(adc_nii,fullfile(savdir,'NIFTI'),'adc');
generate_pdf(adc_img_nii,fullfile(savdir,'NIFTI'),'adc_img');


create_master_pdf(fullfile(savdir,'NIFTI'));
status = movefile(fullfile(savdir,'NIFTI','nii.pdf'),savdir);
system(['rm -f ' fullfile(savdir,'NIFTI','*.pdf')]);
