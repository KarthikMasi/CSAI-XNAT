%Instructions:

%1. Transfer data from snydek1@nmr152.vuiis.vanderbilt.edu located in 
%/opt/PV5.1 /data/snydek1/nmr/KMS_20161014.E31 to 
%/data/snyder/Data/Rat_Brains/Raw on gpu02 

%2. Run MET2_MWF_Katie to recon MET2 data
%1 scan from each of RB20a, RB20b, RB20c, RB20d, RB21a, RB21b, RB21c, RB21d 
%Get SNR for each scan

%3. Run RARE_qMT_anyuser to recon qMT data
%1 scan from each of RB20a, RB20b, RB20c, RB20d, RB21a, RB21b, RB21c, RB21d 
%Get SNR for each scan

%4. Run MWF_fit_Katie to process MET2 data
%Process scans reconned in step 2 

%5. Run qMT_fit_anyuser to process qMT data
%Process scans reconned in step 2 

%6. Run to process DKI data

%7. Run to register images

%8. Run ROI_analysis_Katie to perform ROI analysis
%4 ROIs evaluated

%9. Run graphs to generate graphs
%scatter plots (x: age and gender and y: parameter value) mean parameters for each of 4 ROIs for each brain