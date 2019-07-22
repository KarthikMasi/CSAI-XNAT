function out=reorient2(img,varargin)
% Reorients input image in preparation for splitn. Also aligns images
% for display in .nii pdf.
% Alterations in FOV and brain placement will require adjustment to the
% code. FOV=21.9x15.6x16.2 (permutations of this are allowed)
% 4 mouse brain 7T protocol
%
% Input
%   img=3D image data
%   hranat=orientation correction for HRANAT is different
% Output
%   out=reoriented 3D image

% Reorient principal directions to align same direction as atlas
[~,reorient_ix]=sort(size(img),'descend');
reorient_ix=[reorient_ix(2) reorient_ix(1) reorient_ix(3)];
imgperm=permute(img,reorient_ix);

switch nargin
    case 1
        % Flip back to front to correct V-D
        out=flip(imgperm,1);
    case 2
        % Flip back to front to correct A-P
        out=flip(imgperm,3);
    otherwise
        error('Unexpected inputs');
end