function out=reorient(img,varargin)
% Reorients input image to same orientation as brain atlas 
% (http://brainatlas.mbi.ufl.edu/). Assumes orientation
% based on FOV size and a priori knowledge of brain placement in RF coil.
% Alterations in FOV and brain placement will require adjustment to the
% code. FOV=21.9x15.6x16.2 (permutations are allowed)
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
