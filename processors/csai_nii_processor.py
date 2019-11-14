import os
import logging
from dax import XnatUtils, ScanProcessor

LOGGER = logging.getLogger('dax')

DEFAULT_SPIDER_PATH = '/data/mcr/masimatlab/trunk/xnatspiders/spiders/Spider_full_remmi_process_test.py'
DEFAULT_WALLTIME = '15:00:00'
DEFAULT_MEM = '8000'
DEFAULT_MOUSE_NII_PATH = '/data/mcr/masimatlab/trunk/xnatspiders/matlab/Mouse_mat_nii_update/'
DEFAULT_MATLAB_UTILS_PATH = '/data/mcr/masimatlab/trunk/utils/matlab'
DEFAULT_MATLAB_PATH = '/accre/arch/easybuild/software/BinDist/MATLAB/2018b/bin/matlab'
#DEFAULT_MATLAB_PATH = '/opt/easybuild/software/Core/MATLAB/2017a/bin/matlab'
DEFAULT_TMP_PATH= '/home/ramadak/Results'

csai_CMD = '''python -u {spider_path} \
-d="{job_dir_path}" \
-a="{assessor_label}" \
--project "{project}" \
--subject "{subject}" \
--session "{session}" \
--scan_data "{scan_data}" \
--suffix="{suffix_proc}" \
--matlab_utils="{matlab_utils}" \
--matlab_bin="{matlab_bin}" \
'''

def get_scan_resource_uri(xnat,proj,subj,sess,scan):
    scan_file_uri = 'xnat://projects/{0}/subjects/{1}/experiments/{2}/scans/{3}/resources/{4}'
    scan_obj = xnat.select('/projects/' + proj + '/subjects/' + subj + '/experiments/' + sess + '/scans/' + scan)
    res_file = scan_obj.resources()[0].label()
    uri_path = scan_file_uri.format(proj,subj,sess,scan,res_file)
    return uri_path

class csai_nii_processor(ScanProcessor):
    """ Processor class for skynet """
    def __init__(self, 
                 test_sessions = '',
                 spider_path = DEFAULT_SPIDER_PATH,
                 suffix_proc = '',
                 matlab_utils = DEFAULT_MATLAB_UTILS_PATH,
                 matlab_path = DEFAULT_MATLAB_PATH,
                 walltime = DEFAULT_WALLTIME, 
                 mem = DEFAULT_MEM,
                 scan_types = 'scan_data',
                 version = ''):
        super(csai_nii_processor, self).__init__(scan_types, walltime, mem, spider_path, version, suffix_proc=suffix_proc)
        
        # Set inputs and format them
        self.spider_path = spider_path
        self.test_sessions = test_sessions.split(',')
        self.suffix_proc = suffix_proc
        self.matlab_utils = matlab_utils
        self.matlab_path = matlab_path

    def has_inputs(self, cscan):
        """ function overridden from base class
            returns status, qcstatus
            status = 0 if still NEED_INPUTS, -1 if NO_DATA, 1 if NEED_TO_RUN
            qcstatus = only when status is -1 or 0.
            You can set it to a short string that explain why it's no ready to run.
                e.g: No NIFTI
        """

        # First check to see if test sessions are set in red cap
        if self.test_sessions != ['']:
            # Check to make sure this is a test session
            if cscan.info()['session_label'] not in self.test_sessions:
                return 0, 'Currently in test mode'

        return 1, None

    def get_cmds(self, assessor, job_dir_path):
        """
        This function generates the spider command for the cluster job 
        """
        project = assessor.parent().parent().parent().label()                    
        subject = assessor.parent().parent().label()                             
        session = assessor.parent().label()                                      
        csess = XnatUtils.CachedImageSession(assessor._intf,project,subject,session)
        xnat = XnatUtils.get_interface()
        scan= csess.scans()[0].label() 
        scan_data = get_scan_resource_uri(xnat,project,subject,session,scan)
        cmd = csai_CMD.format(spider_path = self.spider_path,
                               job_dir_path = job_dir_path,
                               assessor_label = assessor.label(),
                               project = project,
                               subject = subject,
                               session = session,
                               scan_data = scan_data,
                               suffix_proc = self.suffix_proc,
                               matlab_utils = self.matlab_utils,
                               matlab_bin = self.matlab_path)
        return [cmd]
