% Organizes the output of antsreg.m in folder dname
function orgoutput(dname)

dname='Outputs_antsreg';
list=dir(dname);

mkdir(fullfile(dname,'Affine'))
mkdir(fullfile(dname,'Warp'))
mkdir(fullfile(dname,'Morph'))
mkdir(fullfile(dname,'Nonrigid'))

pdfdir=fullfile(dname,'pdf');
mkdir(pdfdir)

for ii=3:length(list)
    srcdir=fullfile(dname,list(ii).name);
    if contains(list(ii).name,'_aff_')
        dstdir=fullfile(dname,'Affine');
    elseif contains(list(ii).name,'_Reg0')
        dstdir=fullfile(dname,'Warp');
    elseif contains(list(ii).name,'_morph')
        dstdir=fullfile(dname,'Morph');
    else
        dstdir=fullfile(dname,'Nonrigid');
    end
    movefile(srcdir,dstdir);
end

%% Create PDF from nonrigid registered images

list=dir(fullfile(dname,'Nonrigid'));
for ii=3:length(list)
    img=niftiread(fullfile(dname,'Nonrigid',list(ii).name)); 
    [~,F,~]=fileparts(list(ii).name);
    if contains(F,'mse')
        generate_pdf(img,pdfdir,F,[0 .1]);
    elseif contains(F,'bpf')
        generate_pdf(img,pdfdir,F,[0 .2]);
    elseif contains(F,'fa')
        generate_pdf(img,pdfdir,F,[0 1]);
    elseif contains(F,'adc')
        generate_pdf(img,pdfdir,F,[0 .4]);
    else
        generate_pdf(img,pdfdir,F);
    end
end
create_master_pdf(pdfdir);
movefile(fullfile(pdfdir,'QA.pdf'),dname);
system(['rm -rf ' pdfdir]);