function generate_pdf(nii_file,savdir,filename)

ind = find(nii_file.img(:)>0);
[i,j,k]=ind2sub(size(nii_file.img),ind);


figure(1);
montage(uint8(permute(nii_file.img(:,:,min(k):3:max(k)),[2 1 4 3])*255));
colormap([0 0 0; hsv(5)]); caxis([0 5]);
axis equal;


fig1 = figure(1);
figure(fig1);
title(filename);
set(fig1, 'PaperType','usletter', 'PaperPositionMode','auto', 'PaperOrientation', 'portrait');
pdf_file = [filename '.pdf']
print('-bestfit','-dpsc2','-r400',[savdir '/' pdf_file],fig1);
close(fig1);


                                                                 
