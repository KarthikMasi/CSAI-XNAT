function process_scan(raw,results)
% Process raw scan data to reconstruct images and calculate parameter maps
%
% Input
%   raw=directory containing data on XNAT
%   results=directory containing output data on XNAT
%
% Output 
%   Results are saved in 'results' folder

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

% List the study path and experiments to process
info.spath = fullfile(raw);

% Directory to save
fullmat = fullfile(results,'Full_Data');
parammat = fullfile(results,'Parameter_Maps');

% Create save directory if it doesn't exist
mkdir(fullfile(results,'Full_Data'));
mkdir(fullfile(results,'Parameter_Maps'));

%% HRANAT
if ~isempty(find(contains(M{1},'scannum.hranat')))
    info.exps=str2num(M{2}{contains(M{1},'scannum.hranat')});
    ws_hranat = remmi.workspace(fullfile(fullmat,'hranat.mat'));
    
    % Reconstruct the data
    ws_hranat.images = remmi.recon(info);

    % Save image in MAT
    hranat=ws_hranat.images.img;

    % Reorient to align with atlas
    rhranat=reorient2(abs(hranat),'hranat');
    save(fullfile(parammat,'hranat.mat'),'rhranat');
    
    generate_pdf(rhranat,parammat,'hranat');
end

%% MSE
if ~isempty(find(contains(M{1},'scannum.mse')))
    info.exps=str2num(M{2}{contains(M{1},'scannum.mse')});
    ws_mse = remmi.workspace(fullfile(fullmat,'mse.mat'));
    
    % Reconstruct the data
    ws_mse.images = remmi.recon(info);
    
    % Set a threshold mask
    ws_mse.images = remmi.util.thresholdmask(ws_mse.images,.2);
    dimages = ws_mse.images; % complex denoised
    
    % Size of window
    Nv = ceil(size(ws_mse.images.img,4)^(1/3));
    
    % Denoise complex images
    [dimages.img,~,~] = ...
        denoiseCV(ws_mse.images.img,[Nv,Nv,Nv],ws_mse.images.mask);
    
    % Load denoised images into the remmi workspace, then clear dummies
    ws_mse.dimages = dimages;
    clear dimages
    
    % Multi-exponential T2 Analysis using MERA
    [metrics,fitting,analysis]= remmi.mse.mT2options;
    metrics = rmfield(metrics,'gmT2');
    metrics = rmfield(metrics,'MWF');
    % Fitting parameters
    fitting.B1fit = 'y';
    fitting.regtyp = 'mc';
    fitting.regweight = 1e-1;
    fitting.regadj = 'manual';
    fitting.numberT = 100;
    fitting.rangeT = [ws_mse.images.pars.te(1)*.75,ws_mse.images.pars.te(end)*4/3];
    
    fitting.rangetheta = [135 180]; % normally use 135,180, but B1 is close to 180
    fitting.numbertheta = 10;
    fitting.fixedT1 = .2; % based on previous IR anlaysis
    analysis.tolextract = 0;
    
    % Specify output metrics
    metrics.S = @(out) out.S;
    % metrics.T = @(out) out.T;
    % metrics.SNR = @(out) out.SNR;
    % metrics.Tv = @(out) out.Tv;
    % metrics.Fv = @(out) out.Fv;
    metrics.B1 = @(out) out.theta;
    %metrics.MWF  = ...
    % str2func('@(out) sum(out.Fv.*(out.Tv>0.005 & out.Tv<.027),1)./sum(out.Fv,1)');
    metrics.MWF2  = ...
        str2func('@(out) sum(out.S(8:47,:))./sum(out.S(8:end,:))');
    
    ws_mse.T2spect= remmi.mse.mT2(ws_mse.dimages,metrics,fitting,analysis); 
    
    % mse.dT2spect saves to current directory if mse_full.mat is too large
    % move this to the appropriate directory
    try
        movefile('mse.T2spect.mat',fullfile(fullmat,'mse.T2spect.mat'))
    catch
        warning('mse.T2spect.mat is in MSE.mat');
    end
end

%% SIR
if ~isempty(find(contains(M{1},'scannum.sir')))
    info.exps=str2num(M{2}{contains(M{1},'scannum.sir')});
    ws_sir = remmi.workspace(fullfile(fullmat,'sir.mat'));
    
    % Reconstruct the data
    ws_sir.images = remmi.recon(info);
    
    % Set a threshold mask
    ws_sir.images = remmi.util.thresholdmask(ws_sir.images);
    dimages = ws_sir.images; % complex denoised
    
    % Size of window
    Nv = ceil(size(ws_sir.images.img,4)^(1/3));
    
    % Denoise complex images
    [dimages.img,~,~] = denoiseCV(ws_sir.images.img,[Nv,Nv,Nv],...
        ws_sir.images.mask);
    
    % Load denoised images into the remmi workspace, then clear dummies
    ws_sir.dimages = dimages;
    clear dimages
    
    % Perform qMT analysis
    ws_sir.qMT = remmi.ir.qmt(ws_sir.dimages); 
    
    % Save image in MAT
    bpf=ws_sir.qMT.BPF;
    rawimg=abs(ws_sir.images.img(:,:,:,end));

    % Reorient to align with atlas
    rbpf=reorient2(bpf);
    rrawimg=reorient2(rawimg);
    
    save(fullfile(parammat,'bpf.mat'),'rbpf');
    save(fullfile(parammat,'rawimg.mat'),'rrawimg');
    
    generate_pdf(rbpf,parammat,'bpf',[0 .3]);
end

%% DTI
if ~isempty(find(contains(M{1},'scannum.dti')))
    info.exps=str2num(M{2}{contains(M{1},'scannum.dti')});
    ws_dti = remmi.workspace(fullfile(fullmat,'dti.mat'));
    
    %Reconstruct the data
    ws_dti.images = remmi.recon(info);
    
    % Set a threshold mask
    ws_dti.images = remmi.util.thresholdmask(ws_dti.images);
    
    % Add b matrix
    ws_dti.images = remmi.dwi.addbmatrix(ws_dti.images);
    
    % Perform DTI analysis
    ws_dti.dti = remmi.dwi.dti(ws_dti.images);
    
    % Save image in MAT
    fa=ws_dti.dti.fa;
    adc=ws_dti.dti.adc;
    % Reorient to align with atlas
    rfa=reorient2(fa);
    radc=reorient2(adc);
    save(fullfile(parammat,'fa.mat'),'rfa');
    save(fullfile(parammat,'adc.mat'),'radc');
    
    
    generate_pdf(rfa,parammat,'fa',[0 1]);
    generate_pdf(radc,parammat,'adc',[0 .4]);
end

%% PDF Generation for QA

% Current images: HRANAT, BPF, T1, Inv_eff, ADC, FA

% XNAT detects only 1 master pdf
create_master_pdf(parammat);
status = movefile(fullfile(parammat,'nii.pdf'),results);
system(['rm -f ' fullfile(parammat,'*.pdf')]);


