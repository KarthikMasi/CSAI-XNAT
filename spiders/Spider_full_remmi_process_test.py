#/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Created on Aug 09, 2018

author: Karthik Ramadass
'''
import dax
from dax import AutoSpider

name = 'fullremmiprocesstest'

version = '1.0.0'

exe_lang = 'matlab'

inputs = [
    ("matlab_utils","PATH", "Path to MATLAB utils"),
    ("project","PARAM","project_name"),
    ("subject","PARAM","subject_name"),
    ("session","PARAM","session_name"),
    ("scan_data","FILE","DIR containing all raw data"),
    ("matlab_bin", "PATH", "Path to matlab executable")
]

outputs = [
    ("nii.pdf","FILE","PDF"),
    ("RESULTS", "DIR", "RESULTS") 
]

code = r"""%% call conversion pipeline
clear all;
close all;
clc;
scandata = '${scan_data}'

addpath(genpath('/data/mcr/masimatlab/trunk/xnatspiders/matlab/Mouse_mat_nii_update/'));
addpath('$matlab_utils');

process(scandata,'$temp_dir')

% Move files
system(['mkdir ' fullfile('$temp_dir','RESULTS')]);
system(['mv ' fullfile('$temp_dir','Full_Data') ' ' fullfile('$temp_dir','RESULTS')])
system(['mv ' fullfile('$temp_dir','Parameter_Maps') ' ' fullfile('$temp_dir','RESULTS')])
system(['mv ' fullfile('$temp_dir','Split_Data') ' ' fullfile('$temp_dir','RESULTS')])
system(['mv ' fullfile('$temp_dir','Interp') ' ' fullfile('$temp_dir','RESULTS')])
"""

if __name__ == '__main__':
    spider = AutoSpider(
        name,
        inputs,
        outputs,
        code,
        version=version,
        exe_lang=exe_lang,
    )

    spider.go()
