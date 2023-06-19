#!/bin/bash
#
# scripts/slurm/exec_build.sh
#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# This file is a part of the PAN-RUNTIME package.  For license
# information, see the LICENSE file in the top level directory of
# this distribution.
#

#-- execute the job
SLURM_ID=`sbatch -N1 --export=ALL ./scripts/slurm/build.sh | awk '{print $4}'`

#-- wait for completion
COMPLETE=`squeue -u builduser | grep ${SLURM_ID}`
while [ -n "$COMPLETE" ]; do
  COMPLETE=`squeue -u builduser | grep ${SLURM_ID}`
done

#-- job has completed, test for status
STATE=`cat slurm-${SLURM_ID}.out | grep "FAILED"`

if [ "$STATE" ]; do
  echo "TEST FAILED FOR JOB_ID = ${JOB_ID}; SLURM_JOB=${SLURM_ID}"
  exit -1
done;

exit 0
#-- EOF
