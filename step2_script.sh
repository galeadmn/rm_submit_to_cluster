RMOUT=$1_file${SLURM_ARRAY_TASK_ID}.fasta.masked
RMIN=$1_file${SLURM_ARRAY_TASK_ID}.fasta
RMOTHER=$1_file${SLURM_ARRAY_TASK_ID}.fasta.out

if [ -e $RMIN ]
then
	if [ ! -e $RMOTHER ]
	then
                # The -s specifies slow, high-sensitivity repeat masking
		RepeatMasker -pa 8 -s -spec mouse $RMIN 
     	CHECK=$?
		if [ ${CHECK} -ne 0 ] 
		then
			echo "Fatal Error at RepeatMasker."  
			exit 1
		fi
	fi

	if [ ! -e $RMOUT ]
	then
		cp ${RMIN} ${RMOUT}
	fi
fi
