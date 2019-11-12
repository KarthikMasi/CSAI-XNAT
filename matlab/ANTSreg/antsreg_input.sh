antsRegistration --dimensionality 3 --float 0  \
 --output [$3_Reg] \
        --interpolation Linear \
        --winsorize-image-intensities [0.005,0.995] \
        --use-histogram-matching 0 \
        --transform SyN[0.1,3,0] \
        --metric CC[$1,$2,1,4] \
        --convergence [100x70x50x20,1e-6,10] \
        --shrink-factors 8x4x2x1 \
        --smoothing-sigmas 3x2x1x0vox 
