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

% Correct shift in phase encode direction
cor=round(size(img,3)*0.1);
img=cat(3,img(:,:,end-cor+1:end),img(:,:,1:end-cor));

% Reorient principal directions to align same direction as atlas
[~,reorient_ix]=sort(size(img),'descend');
reorient_ix=[reorient_ix(2) reorient_ix(1) reorient_ix(3)];

% Flip left to right to correct L-R
imgflip=flip(permute(img,reorient_ix),2);

switch nargin
    case 1
        % Flip back to front to correct A-P
        out=flip(imgflip,3);
    case 2
        % Flip upside down to correct V-D
        out=flip(imgflip,1);
    otherwise
        error('Unexpected inputs');
end
% for ii=1:size(out,3)
%     imagesc(out(:,:,ii))
%     title(num2str(ii))
%     waitforbuttonpress
% end
