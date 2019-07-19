#!/usr/bin/env python
# -*- coding: utf-8 -*-

import nibabel
import argparse
import os

def change_dimensions(img):
    """
    """
    f=nibabel.load(img)
    print("Changing pixel resolution in x,y,z....")
    f.header['pixdim']=[1.,0.150,0.150,0.150,0.,0.,0.,0.]
    f.header['xyzt_units']=10
    print("Resolution changed to 0.150mm isotropic resolution")
    return f

def save_nifti(img,save_as):
    """
    """
    filename = os.path.splitext(save_as)[0]
    save_as = filename +'.nii.gz'
    nibabel.save(img,save_as)
    print("Image Reoriented")

def add_to_parser():
    """
    """
    parser = argparse.ArgumentParser(description='Crontabs manager')
    parser.add_argument("--file","-f",dest='img',\
        help='nii file to be reoriented',required=True)
    parser.add_argument("--save_as","-s",dest='save_as',\
        help='filepath/filename to be saved to',required=True)
    return parser

def execute():
    """
    execution point
    """
    parser = add_to_parser()
    OPTIONS = parser.parse_args()
    f = change_dimensions(OPTIONS.img)
    save_nifti(f,OPTIONS.save_as)

if __name__=='__main__':
    execute()


