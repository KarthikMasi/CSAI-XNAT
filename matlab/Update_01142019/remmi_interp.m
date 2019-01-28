function out=remmi_interp(img,varargin)
% Interpolates raw image data to match resolution and FOV of atlas
% https://www.mathworks.com/help/matlab/math/resample-image-with-gridded-interpolation.html
%
% Input
%   img=uninterpolated image data
%   res=resolution of each voxel in parameter map in mm [x y z]
%   asize=atlas image size in number of voxels [x y z]
%   resa=resolution of each voxel in reference atlas in mm [x y z]
%   
% Output
%   out=interpolated image data

% Resolution of map
res=[.15 .15 .15];

% Use predefined atlas and resolution data unless specified otherwise
% Load reference atlas image
asize=[256, 256, 512];

% Resolution of atlas
resa=[.047 .047 .047];

switch nargin
    case 2
        res=varargin{1};
    case 3
        asize=varargin{2};
    case 4
        resa=varargin{3};
end

%% Interpolate map to same size as reference image

% Atlas size
sx_ref=asize(1);
sy_ref=asize(2);
sz_ref=asize(3);

% Matrix size of image to interpolate
[sx_map,sy_map,sz_map]=size(img);

% Setup interplation kernel
interp_method='spline';
Fmap=griddedInterpolant(double(img));
Fmap.Method=interp_method;

% Grid vectors to resample maps
xq_map=(0:resa(1)/res(1):sx_map)';
yq_map=(0:resa(2)/res(2):sy_map)';
zq_map=(0:resa(3)/res(3):sz_map)';

% Resampled maps to same resolution as reference atlas
vq_map=Fmap({xq_map,yq_map,zq_map});
[sx_map,sy_map,sz_map]=size(vq_map);

% Zeropad map to same matrix size as atlas
padmat=[round((sx_ref-sx_map)/2) round((sy_ref-sy_map)/2) round((sz_ref-sz_map)/2)];
% Do not pad by an amount less than 0
padmat(padmat<0)=0;
vq_map=padarray(vq_map,padmat);

% Zeropadded map may have one extra row of zeros in a dimension if
% original map matrix size has an odd number in one of its dimensions
% Remove this row of zeros so that matrix size is same as atlas
vq_map=vq_map(1:sx_ref,1:sy_ref,1:sz_ref);

% Interpolated image
out=vq_map;



