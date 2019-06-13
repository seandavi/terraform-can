#!/bin/bash
BOOK_REPO=$1
BOOK_PATH=$2
PKG_REPO=$3
R_REMOTES_NO_ERRORS_FROM_WARNINGS=1
Rscript builder2.R $BOOK_REPO $BOOK_PATH $PKG_REPO
OBJ_PATH=s3://${BUILD_BUCKET}/jobs/${AWS_BATCH_JOB_ID}
#aws s3 cp abc.html $OBJ_PATH/
cd $BOOK_PATH
echo $OBJ_PATH
aws s3 cp --recursive --exclude="*" --include "*.log" . $OBJ_PATH/
aws s3 cp --recursive _book $OBJ_PATH/_book
