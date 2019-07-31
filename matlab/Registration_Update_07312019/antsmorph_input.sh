antsApplyTransforms -i "$1_affmorph_result.nii.gz" -o "$1_nonrigidmorph_result.nii.gz" -r $2 -n BSpline -t "$3"
antsApplyTransforms -i "$1_affmorph_label.nii.gz" -o "$1_nonrigidmorph_label.nii.gz" -r $2 -n MultiLabel -t "$3"
