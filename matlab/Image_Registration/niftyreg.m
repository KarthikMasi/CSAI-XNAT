function [out,cpp]=niftyreg(ref,flo,regdir,cppath,varargin)
% Performs block-matching and non-rigid deformation to register an image
% to a reference image.
%
% Input
%   ref=reference image
%   flo=nonregistered image
%   regdir=directory to temporarily store registration output
%   cppath=path to store control point output
%
% OPTIONAL Input:
%   resample=option to use predefined control points from cppath to deform 
%   image using reg_resample in NiftyReg package (usage: 'resample')
%
% Output
%   out=registered .mat image
%   cpp=control points used to deform image

% Use reg_aladin and reg_f3d if no control point input
% Use reg_resample if control point input exists

switch nargin
    case 4  
        %% Create a reference mask
        ref=double(ref); % Convert to double for calculation purposes

        % Scale moving image to match atlas
        n=max(ref(:))/max(flo(:));
        
        % Convert to double so that ref and flo images have same data type
        ref=double(ref);
        flo=double(n*flo);
        
        % Create a reference mask
        rmask=double(ref > 0.1*max(ref(:)));
        
        %% Stage 1: Global registration using block matching algorithm (~45s)
        niftiwrite(rmask,fullfile(regdir,'rmask.nii'));
        niftiwrite(ref,fullfile(regdir,'ref.nii'));
        niftiwrite(flo,fullfile(regdir,'flo.nii'));
        
        % Enhances alignment of internal features
        %reg_aladin -rmask rmask.nii -lp 2 -ref ref.nii -flo flo.nii -aff
        %outAff.txt -res stage1.nii
        cmd1=sprintf('%s %s %s %s %s %s %s %s %s %s %s %s',...
            'reg_aladin','-rmask',fullfile(regdir,'rmask.nii'),'-lp 2','-ref',fullfile(regdir,'ref.nii'),...
            '-flo',fullfile(regdir,'flo.nii'),'-aff',fullfile(regdir,'outAff.txt'),'-res',...
            fullfile(regdir,'block.nii'));
        [~,~]=system(cmd1);

        %% Stage 2: Non-rigid deformation
        cmd2=sprintf('%s %s %s %s %s %s %s %s %s %s %s','reg_f3d',...
            '-aff',fullfile(regdir,'outAff.txt'),'-ref',fullfile(regdir,'ref.nii'),...
            '-flo',fullfile(regdir,'flo.nii'),'-cpp',...
            cppath,'-res',...
            fullfile(regdir,'reg.nii'));
        [~,~]=system(cmd2);
        
        % Rescale image to correct values
        out=niftiread(fullfile(regdir,'reg.nii'));
        out=out/n;
        cpp=niftiread(cppath);
        
    case 5
        ref=double(ref);
        flo=double(flo);
        
        niftiwrite(ref,fullfile(regdir,'ref.nii'));
        niftiwrite(flo,fullfile(regdir,'flo.nii'));
        
        %% Resample given control points
        cmd3=sprintf('%s %s %s %s %s %s %s %s %s','reg_resample',...
            '-ref',fullfile(regdir,'ref.nii'),'-flo',fullfile(regdir,'flo.nii'),'-cpp',...
            cppath,'-res',fullfile(regdir,'res.nii'));
        [~,~]=system(cmd3);
        
        out=niftiread(fullfile(regdir,'res.nii'));
        cpp=niftiread(cppath);
        
    otherwise
        error('Unexpected inputs');
end

