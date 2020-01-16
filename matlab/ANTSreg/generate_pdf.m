% Creates a QA pdf by displaying several slices in img
% Can specify a [min max] colormap color range for varargin
function generate_pdf(img,savdir,filename,varargin)

if contains(filename,'hranat')
    img=img./max(img(:));
end

% Find axial slices that are not background (>0)
ind = find(img(:)>1e-10);
[~,j,~]=ind2sub(size(img),ind);

% Display 16 evenly spaced slices
sl=round(linspace(min(j),max(j),16));

img2=permute(img,[1 3 2]); % make axial orientation last dimension
% make a new image volume with selected slices
img3=zeros(size(img2,1),size(img2,2),length(sl));
for ii=1:size(img3,3)
    img3(:,:,ii)=imrotate(squeeze(img2(:,:,sl(ii))),90);
end

switch nargin
    case 3
        figure(1);
        if contains(filename,'hranat')
            montage(img3);colormap(gray);colorbar;
        else
            montage(img3);colormap(jet);colorbar;
        end
        axis equal;
    case 4
        color_range=varargin{1};
        figure(1);
        montage(img3);caxis(color_range);colormap(jet);colorbar;
        axis equal;
    otherwise
        error('Unexpected inputs');
end

fig1 = figure(1);
figure(fig1);
title(filename,'Interpreter','none');
set(fig1, 'PaperType','usletter', 'PaperPositionMode','auto', 'PaperOrientation', 'portrait');
print('-bestfit','-dpdf','-r400',[savdir '/' filename '.pdf'],fig1);
close(fig1);


                                                                 
