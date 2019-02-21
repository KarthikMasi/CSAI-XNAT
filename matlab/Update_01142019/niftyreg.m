function [out,cpp]=niftyreg(ref,flo,regdir,regcmd,varargin)
% Performs block-matching and non-rigid deformation to register an image
% to a reference image.
%
% Input
%   ref=reference image
%   flo=nonregistered image
%   regdir=directory containing reference image
%   regcmd=command for registration
%
% OPTIONAL:
%   cpp=predefined control poins used to deform 
%   image using reg_resample in NiftyReg package
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
        
        % Convert to double to match atlas
        ref=double(ref);
        flo=double(n*flo);
        
        % Create a reference mask
        rmask=double(ref > 0.1*max(ref(:)));
        
        %% Stage 1: Global registration using block matching algorithm (~45s)
        niftiwrite(rmask,'rmask.nii');
        niftiwrite(ref,'ref.nii');
        niftiwrite(flo,'flo.nii');
        
        % Enhances alignment of internal features
        %reg_aladin -rmask rmask.nii -lp 2 -ref ref.nii -flo flo.nii -aff
        %outAff.txt -res stage1.nii
        cmd1=sprintf('%s "%s %s %s %s %s %s %s %s %s %s %s %s"',regcmd,...
            'reg_aladin','-rmask',[regdir 'rmask.nii'],'-lp 2','-ref',[regdir 'ref.nii'],...
            '-flo',[regdir 'flo.nii'],'-aff',[regdir 'outAff.txt'],'-res',...
            [regdir 'block.nii']);
        [~,~]=system(cmd1);

        %% Stage 2: Non-rigid deformation
        cmd2=sprintf('%s "%s %s %s %s %s %s %s %s %s %s %s"',regcmd,'reg_f3d',...
            '-aff',[regdir 'outAff.txt'],'-ref',[regdir 'ref.nii'],...
            '-flo',[regdir 'flo.nii'],'-cpp',...
            [regdir 'cpp.nii'],'-res',...
            [regdir 'reg.nii']);
        [~,~]=system(cmd2);
        
        % Rescale image to correct values
        out=niftiread('reg.nii');
        out=out/n;
        cpp=niftiread('cpp.nii');
        
    case 5
        cpp=varargin{1};
        niftiwrite(cpp,'cpp.nii');
        niftiwrite(ref,'ref.nii');
        niftiwrite(flo,'flo.nii');
        
        %% Resample given control points
        niftiwrite(ref,[regdir 'ref.nii']);
        niftiwrite(flo,[regdir 'flo.nii']);
        cmd3=sprintf('%s "%s %s %s %s %s %s %s %s %s"',regcmd,'reg_resample',...
            '-ref',[regdir 'ref.nii'],'-flo',[regdir 'flo.nii'],'-cpp',...
            [regdir 'cpp.nii'],'-res',[regdir 'res.nii']);
        [~,~]=system(cmd3);
        
        out=niftiread([regdir 'res.nii']);
        cpp=niftiread([regdir 'cpp.nii']);
    otherwise
        error('Unexpected inputs');
end

