function hdrinfo(nii_file,voxdim)
% Inputs the correct NIFTI header metadata information based on voxel size
% and LPS orientation
%
% Input
%   nii_file=directory to NIFTI file
%   voxdim=[x y z] voxel dimensions in mm

% Read in image data and metadata
img=niftiread(nii_file);
info=niftiinfo(nii_file);

% Edit header info
info.Description='';
info.PixelDimensions=[voxdim(1) voxdim(2) voxdim(3)];
info.SpaceUnits='Millimeter';
info.TimeUnits='Second';
info.MultiplicativeScaling=1;
info.TransformName='Sform';
info.Transform.T=[voxdim(1) 0 0 0; 0 voxdim(2) 0 0; 0 0 voxdim(3) 0; ...
    voxdim(1) voxdim(2) voxdim(3) 1];
info.raw.pixdim=[1 voxdim(1) voxdim(2) voxdim(3) 0 0 0 0];
info.raw.qform_code=2;
info.raw.sform_code=2;

% Resave data with corrected metadata
niftiwrite(img,nii_file,info)