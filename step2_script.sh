RMOUT=$3_file${SLURM_ARRAY_TASK_ID}.fasta.masked
RMIN=$3_file${SLURM_ARRAY_TASK_ID}.fasta
RMOTHER=$3_file${SLURM_ARRAY_TASK_ID}.fasta.out

if [ -e $RMIN ]
then
	if [ ! -e $RMOTHER ]
	then
                echo $2
                if [ $2 -eq "1" ]
                then
                    # The -s specifies slow, high-sensitivity repeat masking
		    RepeatMasker -pa 8 -s -spec $1 $RMIN 
                else
		    RepeatMasker -pa 8 -spec $1 $RMIN 
                fi
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
if
