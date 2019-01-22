function create_master_pdf(out_path)
cmmd = strcat("gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=",...
    fullfile(out_path,'nii.pdf')," ",fullfile(out_path,'hranat.pdf')," ",...
    fullfile(out_path,'bpf.pdf')," ",fullfile(out_path,'t1.pdf')," ",...
    fullfile(out_path,'inv_eff.pdf')," ",fullfile(out_path,'adc.pdf')," ",...
    fullfile(out_path,'fa.pdf'))
system(char(cmmd));
