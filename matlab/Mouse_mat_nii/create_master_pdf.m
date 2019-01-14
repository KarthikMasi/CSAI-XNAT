function create_master_pdf(out_path)
cmmd = strcat("gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=",fullfile(out_path,'nii.pdf')," ",fullfile(out_path,'anat.pdf')," ",fullfile(out_path,'mwf.pdf')," ",fullfile(out_path,'mwf_img.pdf')," ",fullfile(out_path,'bpf.pdf')," ",fullfile(out_path,'bpf_img.pdf')," ",fullfile(out_path,'adc.pdf')," ", fullfile(out_path,'adc_img.pdf'))
system(char(cmmd));

