function generate_pdf(nii_file,savdir,filename,varargin)
img=nii_file.img;

if strcmp(filename,'hranat')
    img=reorient(abs(img),'hranat');
    img=histeq(img./max(img(:)));
    sl=18;
else
    img=reorient(abs(img));
    sl=6;
end
ind = find(img(:)>0);
[~,~,k]=ind2sub(size(img),ind);

switch nargin
    case 3
        figure(1);
        if strcmp(filename,'hranat')
            montage(img(:,:,min(k):sl:max(k)));colormap(gray);colorbar;
        else
            montage(img(:,:,min(k):sl:max(k)));colormap(jet);colorbar;
        end
        axis equal;
    case 4
        color_range=varargin{1};
        figure(1);
        montage(img(:,:,min(k):sl:max(k)));caxis(color_range);colormap(jet);colorbar;
        axis equal;
    otherwise
        error('Unexpected inputs');
end

fig1 = figure(1);
figure(fig1);
title(filename);
set(fig1, 'PaperType','usletter', 'PaperPositionMode','auto', 'PaperOrientation', 'portrait');
print('-bestfit','-dpsc2','-r400',[savdir '/' filename '.pdf'],fig1);
close(fig1);


                                                                 
