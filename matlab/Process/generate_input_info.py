#!/usr/bin/env python
# -*- coding: utf-8 -*-

import redcap
import os
import sys 
import argparse
import logging as LOGGER
import re

def redcap_project_access(API_KEY):
    """ 
    Access point to REDCap form
    :param API_KEY:string with REDCap database API_KEY
    :return: redcap Project Object
    """
    try:
        project = redcap.Project('https://redcap.vanderbilt.edu/api/', API_KEY)
    except:
        LOGGER.error('ERROR: Could not access redcap. Either wrong API_URL/API_KEY or redcap down.')
        sys.exit(1)
    return project


def retrieve_subject(data,subject_id):
    """
    Search for scan data folder name where subject ID matches. 
    :param data: REDCap data from project exported as list
    :param subject_id: Subject ID as string
    :return: study as dict
    """
    for study in data:
        if(study.get('study_no')==subject_id):
            return study
    LOGGER.error("Subject not found in REDCap")
    sys.exit(1)

def get_scan_numbers(subject):
    """
    Retrieves the scan numbers
    :param subject: study as dict
    :return: dict of scans with scan number 
    """
    scannum={}
    scan_types={1: 'hranat', 2: 'mse', 3: 'sir', 4: 'dti'}
    for x in range(1,5):
        if int(subject.get('scantype___'+str(x)))==1:
            scannum[str(scan_types.get(x))]=subject.get('scannum_'+str(scan_types.get(x)))
    return scannum if scannum is not None else "ERROR retrieving scan types or no scan types selected on REDCap Database(incomplete)"

def get_mouse_slot_no(subject): 
    """
    Creates list with the mouse slot numbers in the order as recorded on REDCAP database.
    :param: study as dict
    :return: mouse slot numbers as list
    """
    no_of_slots = int(subject.get('holder_info'))
    mouse_id = []
    for i in range(0,no_of_slots):
        id_str =  "mouse_id_"+str(i+1)
        mouse_id.append(str(subject.get(id_str)))
    return mouse_id

def generate_text_file(scannum,mouse_id,file_path):
    """
    Opens file if not exists, populates string, saves file.
    :param scannum: dict of scan numbers
    :param mouse_id: mouse slot numbers as list
    :param file_path: string of filepath
    :return: None
    """
    if os.path.exists(file_path):
        os.remove(file_path)
    f = open(file_path,"w+")
    for keys in scannum:
        f.write("scannum."+keys+"="+str(scannum.get(keys))+"\n")
    f.write("brain_idx=")
    for id in mouse_id:
        f.write(id)
        if not id==mouse_id[len(mouse_id)-1]:
            f.write(",")
    f.close()
    print("INPUT file "+file_path+" created")

def add_to_parser():
    """
    Add arguments to default parser
    :return: parser object
    """
    parser = argparse.ArgumentParser(description='REDCap to XNAT')
    parser.add_argument("-k","--key",dest='API_KEY',default=None,\
                required=True, help='API Key to REDCap database')
    parser.add_argument("-s","--subject_id",dest='subject',default=None, \
                required=True, help='subject ID')
    parser.add_argument("-f","--file",dest='file_path',default=None,\
                        required=True, help='Output text file path')
    return parser

if __name__ == '__main__':
    parser = add_to_parser()
    OPTIONS = parser.parse_args()
    LOGGER.basicConfig(level=LOGGER.DEBUG,\
                    format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',\
                       datefmt='%Y-%m-%d %H:%M:%S')
    console = LOGGER.StreamHandler()
    console.setLevel(LOGGER.INFO) 
    project = redcap_project_access(OPTIONS.API_KEY)
    data = project.export_records()
    subject = retrieve_subject(data,OPTIONS.subject)
    mouse_ids = get_mouse_slot_no(subject)
    scans = get_scan_numbers(subject)
    generate_text_file(scans,mouse_ids,OPTIONS.file_path)
