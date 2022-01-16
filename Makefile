SHELL:=/bin/bash
include .env

.PHONY: all clean validate test docs format

all: validate test docs format

clean:
	rm -rf .terraform/

validate:
	$(TERRAFORM) init && $(TERRAFORM) validate && \
		$(TERRAFORM) init modules/locally_signed && $(TERRAFORM) validate modules/locally_signed && \
		$(TERRAFORM) init modules/self_signed && $(TERRAFORM) validate modules/self_signed && \
		$(TERRAFORM) init modules/letsencrypt && $(TERRAFORM) validate modules/letsencrypt

test: validate
	$(CHECKOV) -d /work && \
		$(CHECKOV) -d /work/modules/locally_signed && \
		$(CHECKOV) -d /work/modules/self_signed && \
		$(CHECKOV) -d /work/modules/letsencrypt

docs:
	$(TERRAFORM_DOCS) markdown ./ >./README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/locally_signed >./modules/locally_signed/README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/self_signed >./modules/self_signed/README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/letsencrypt >./modules/letsencrypt/README.md

format:
	$(TERRAFORM) fmt -list=true ./ && \
		$(TERRAFORM) fmt -list=true ./modules/locally_signed && \
		$(TERRAFORM) fmt -list=true ./modules/self_signed && \
		$(TERRAFORM) fmt -list=true ./modules/letsencrypt
