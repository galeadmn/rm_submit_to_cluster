#!/usr/bin/python36
##########################################################
# This script extracts the RepeatMasker step from the    #
# VirusSeeker software pipeline written by Guoyan Zhao   #
# (email: gzhao@pathology.wustl.edu)                     #
#                                                        #
# This modified script was written by Frank Fernandez    #
# (email: fcf@uw.edu) of the Gale Lab at the University  #
# of Washington.                                         #
##########################################################
import sys
import subprocess
import os

##########################################################
# Constants                                              #
##########################################################
slurm_partition = "RepeatMasker"
script_directory = "/share/RM_SCRIPTS/"
num_seq_per_file_repeatmasker = 36000
file_number_of_repeatmasker = 30


usage_text = "rm_submit_to_cluster.py <full path to directory containing fasta file> <name of fasta file> <output directory>\n"

if len(sys.argv) != 4:
    print("usage:\n" + usage_text)
    exit(1)

project_directory = sys.argv[1]
if not os.path.exists(project_directory):
    print(project_directory + " does not exist.\n")
    exit(1)
if not os.path.isdir(project_directory):
    print(project_directory + " is not a directory.\n")
    exit(1)
if project_directory[-1] == '/':
    project_directory = project_directory[:-1]

input_file = sys.argv[2] 
if not os.path.exists(project_directory + "/" + input_file):
    print (project_directory + "/" + input_file + " does not exist.\n")

output_directory = sys.argv[3]
if not os.path.exists(output_directory):
    print(output_directory + " does not exist.\n")
    exit(1)
if not os.path.isdir(output_directory):
    print(output_directory + " is not a directory.\n")
    exit(1)



# This step chops the fasta file into file_number_of_repeatmasker pieces for submission to 
# nodes in the cluster
proc = (subprocess.Popen(["sbatch","--partition="+slurm_partition, script_directory+"step1.pl","-d",project_directory,"-i", input_file,"-o",output_directory, 
        "-f",str(file_number_of_repeatmasker),"-n",str(num_seq_per_file_repeatmasker)], stdout=subprocess.PIPE) )
job_output = proc.communicate()[0].decode('utf-8')
job_id = job_output.strip("\n").split(" ")[-1]
print("RepeatMasker preprocessing submitted: JobId = " + job_id + "\n")

proc = subprocess.Popen(["sbatch","--partition="+slurm_partition, "--dependency=afterok:"+job_id, script_directory+"step2.sh",output_directory+"/"+input_file], stdout=subprocess.PIPE)
job_output = proc.communicate()[0].decode('utf-8')
job_id = job_output.strip("\n").split(" ")[-1]
print("RepeatMasker queued for processing: JobId = " + job_id + "\n")


