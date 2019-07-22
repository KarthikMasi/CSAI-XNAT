%Instructions:

%1. Transfer data from snydek1@nmr152.vuiis.vanderbilt.edu located in 
%/opt/PV5.1 /data/snydek1/nmr/KMS_20161014.E31 to 
%/data/snyder/Data/Rat_Brains/Raw on gpu02 

%2. Run MET2_MWF_Katie to recon data
%13 scans from RB21d (scan numbers 35 to 47)
%Get SNR for each scan

%3. Run MWF_fit_Katie to process data
%Process 13 scans from above 
%Generate MWFmapFvMc needed for precision measurements

%4. Run FA_mask to create FA mask needed for step 5
%load DKI data for Rat ID (RB21d)

%5. Run sd_pooled_pervox.m to calculate standard deviation and confidenc
%intervals per voxel, pooled standard deviation, and scatter plots of MWF
%vs standard deviation per voxel for each set of scans
%set Rat ID (RB21d)
%set number of scans in each set (6 of 2 avg, 3 of 6 avg, 3 of 10 avg)
