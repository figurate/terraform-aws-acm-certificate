SHELL:=/bin/bash
include .env

VERSION=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: all clean providers validate test diagram docs format release

all: test docs format

clean:
	rm -rf .terraform/

providers:
	$(TERRAFORM) providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64

validate:
	$(TERRAFORM) init -upgrade && $(TERRAFORM) validate && \
		$(TERRAFORM) -chdir=modules/locally_signed init -upgrade && $(TERRAFORM) -chdir=modules/locally_signed validate && \
		$(TERRAFORM) -chdir=modules/self_signed init -upgrade && $(TERRAFORM) -chdir=modules/self_signed validate && \
		$(TERRAFORM) -chdir=modules/letsencrypt init -upgrade && $(TERRAFORM) -chdir=modules/letsencrypt validate

test: validate
	$(CHECKOV) -d /work
	$(TFSEC) /work

diagram:
	$(DIAGRAMS) diagram.py

docs: diagram
	$(TERRAFORM_DOCS) markdown ./ >./README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/locally_signed >./modules/locally_signed/README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/self_signed >./modules/self_signed/README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/letsencrypt >./modules/letsencrypt/README.md

format:
	$(TERRAFORM) fmt -list=true ./ && \
		$(TERRAFORM) fmt -list=true ./modules/locally_signed && \
		$(TERRAFORM) fmt -list=true ./modules/self_signed && \
		$(TERRAFORM) fmt -list=true ./modules/letsencrypt

release: test
	git tag $(VERSION) && git push --tags
