function generate_pdf(img,savdir,filename,varargin)

if strcmp(filename,'hranat')
    img=histeq(img./max(img(:)));
end

ind = find(img(:)>0);
[~,~,k]=ind2sub(size(img),ind);

% Display 16 slices
sl=round(linspace(min(k),max(k),16));

switch nargin
    case 3
        figure(1);
        if strcmp(filename,'hranat')
            montage(img(:,:,sl));colormap(gray);colorbar;
        else
            montage(img(:,:,sl));colormap(jet);colorbar;
        end
        axis equal;
    case 4
        color_range=varargin{1};
        figure(1);
        montage(img(:,:,sl));caxis(color_range);colormap(jet);colorbar;
        axis equal;
    otherwise
        error('Unexpected inputs');
end

fig1 = figure(1);
figure(fig1);
title(filename);
set(fig1, 'PaperType','usletter', 'PaperPositionMode','auto', 'PaperOrientation', 'portrait');
print('-bestfit','-dpdf','-r400',[savdir '/' filename '.pdf'],fig1);
close(fig1);


                                                                 
