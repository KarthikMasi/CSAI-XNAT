import os
import logging
from dax import XnatUtils, ScanProcessor

LOGGER = logging.getLogger('dax')

DEFAULT_SPIDER_PATH = '/data/mcr/masimatlab/trunk/xnatspiders/spiders/Spider_full_remmi_process_test.py'
DEFAULT_WALLTIME = '01:00:00'
DEFAULT_MEM = '8000'
DEFAULT_MOUSE_NII_PATH = '/data/mcr/masimatlab/trunk/xnatspiders/matlab/Mouse_mat_nii/'
DEFAULT_MATLAB_UTILS_PATH = '/data/mcr/masimatlab/trunk/utils/matlab'
DEFAULT_MATLAB_PATH = '/opt/easybuild/software/Core/MATLAB/2017a/bin/matlab'
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

def get_uri(xnat, proj, subj, sess, scan, res,job_dir_path):
    scan_file_uri = 'xnat://projects/{0}/subjects/{1}/experiments/{2}/scans/{3}/resources/{4}/'
    scan_obj = xnat.select('/projects/' + proj + '/subjects/' + subj + '/experiments/' + sess + '/scans/' + scan)
    uri_file = scan_obj.resource(res).files().get()
    #print("JOB_DIR_PATH",job_dir_path)
    os.system("mkdir "+job_dir_path)
    uri_path = scan_obj.resource(res).get(job_dir_path,extract=True)
    uri_path = job_dir_path+"/"+res
    #print uri_file
    #uri_path = scan_file_uri.format(proj, subj, sess, scan, res)
    #csess = XnatUtils.CachedImageSession(xnat,proj,subj,sess)
    #uri_path = XnatUtils.get_good_scans(csess,'RAW')
    return uri_path


def get_resource_uri(xnat,proj, subj, sess, scan, res,job_dir_path):
    scan_file_uri = 'xnat://projects/{0}/subjects/{1}/experiments/{2}/scans/{3}/out/resources/{4}'
    #resource_obj = xnat.select('/projects/' + proj + '/subjects/' + subj + '/experiments/'+ sess + '/scans/' + scan +'/resources/'+res)
    #print("resource_obj",resource_obj)
    #resource_obj.get(job_dir_path,extract=True)
    uri_path = scan_file_uri.format(proj, subj, sess,scan,res)
    uri = xnat.select(uri_path)
    #print(uri_path)
    uri.get(job_dir_path,extract=True)
    return uri_path

def get_file_resource_uri(proj, subj, sess, assessor, res, file):
    scan_file_uri = 'xnat://projects/{0}/subjects/{1}/experiments/{2}/scans/{3}/resources/{4}/files/{5}'
    uri_path = scan_file_uri.format(proj, subj, sess, assessor, res, file)
    return uri_path

def get_single_file_resource_uri(xnat, proj, subj, sess, assr, res):
    assr_file_uri = 'xnat://projects/{0}/subjects/{1}/experiments/{2}/assessors/{3}/out/resources/{4}/files/{5}'
    assr_obj = xnat.select('/projects/' + proj + '/subjects/' + subj + '/experiments/' + sess + '/assessors/' + assr)

    uri_file = assr_obj.resource(res).files().get()[0]
    uri_path = assr_file_uri.format(proj, subj, sess, assr, res, uri_file)
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
        scan = assessor.label().split('-x-')[3]
        xnat = XnatUtils.get_interface()
        #scan_data = get_resource_uri(xnat,project,subject,session,scan,'raw',job_dir_path)
        scan_data = get_uri(xnat,project,subject,session,scan,'raw',job_dir_path)
        #scan_data = os.path.join(job_dir_path,'raw')
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
