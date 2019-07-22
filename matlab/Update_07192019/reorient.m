function out=reorient(img)
% Reorients input image such that brains are aligned using standard 
% anatomical LPS (left/posterior/superior) coordinates. See third figure in
% http://help.brain-map.org/display/mousebrain/API for example.
% Input image is pulled from Split_Data folder
%
% Input
%   img=3D image data
% Output
%   out=reoriented 3D image

% Reorient principal directions to be standard anatomical LPS orientation
imgperm=permute(img,[2 3 1]);
out=flip(imgperm,3);
