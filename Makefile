SHELL := /bin/bash

include .env
export


ifneq ("$(wildcard $(DBT_CREDENTIALS_PATH))","")
	export $(shell jq -r 'to_entries|map("DBT_\(.key|ascii_upcase)=\(.value|tostring)")|.[]' ${DBT_CREDENTIALS_PATH})
endif
# export $(shell jq -r 'to_entries|map("KAGGLE_\(.key|ascii_upcase)=\(.value|tostring)")|.[]' ${KAGGLE_CREDENTIALS_PATH})
# .PHONY: print_vars
# print_vars:
#	 @echo "KAGGLE_USERNAME = ${KAGGLE_USERNAME}"
#	 @echo "KAGGLE_KEY = ${KAGGLE_KEY}"

.EXPORT_ALL_VARIABLES:

TF_VAR_project = ${GCP_PROJECT_ID}
TF_VAR_region = $(GCP_REGION)
TF_VAR_BQ_DATASET = $(GCP_BIGQUERY_DATASET)
TF_VAR_BQ_DATASET_DBT_DEV = $(DBT_DEV_DATASET_NAME)
TF_VAR_BQ_DATASET_DBT_PROD = $(DBT_PROD_DATASET_NAME)
TF_VAR_data_lake_bucket = $(GCP_BUCKETNAME)

GOOGLE_APPLICATION_CREDENTIALS = ${GCP_CREDENTIALS_PATH}

REPO_DIR = ${PWD}


#######################################################################

test:
	echo ${KAGGLE_USERNAME}

vm_install_anaconda:
	cd /home/$(USER);\
	wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh;\
	bash Anaconda3-2022.10-Linux-x86_64.sh;\
	source .bashrc

# vm_install_docker:
# 	sudo apt-get install docker.io;\
# 	sudo groupadd docker;\
# 	sudo gpasswd -a ${USER} docker;\
# 	RESTART
# 	# RESTAAAAAAAAAAAAAAAAAAAAART
# 	# sudo service docker restart


# vm_install_docker_compose:
# 	sudo apt-get update -y
# 	sudo apt install docker docker-compose python3-pip make -y
# 	sudo chmod 666 /var/run/docker.sock


# copy gcp creds
# copy kaggle creds, dbt as json
# pip clone
# install anaconda, docker, compose,
# install req

#############################################
################# VM ENVIRONMENT
##############################################
vm_setup:
	cd /home/$(USER)/;\
	sudo apt-get update -y;\
	sudo apt-get install unzip;\
	sudo apt-get install wget;\
	cd $(REPO_DIR);\
	gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS};\


