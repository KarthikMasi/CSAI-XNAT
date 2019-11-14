% Concatenates all existing pdfs in pdfdir into one pdf file
function create_master_pdf(pdfdir)
pathinfo='';
list=dir(pdfdir);
for ii=3:length(list)
    pathinfo=[pathinfo fullfile(pdfdir,list(ii).name) ' '];
end

% Output into QA.pdf
cmmd = ['gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=',...
    fullfile(pdfdir,'QA.pdf'),' ',pathinfo];
system(cmmd);

