SHELL:=/bin/bash
TERRAFORM_VERSION=0.12.24
TERRAFORM=docker run --rm -v "${PWD}:/work" -e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) -e http_proxy=$(http_proxy) --net=host -w /work hashicorp/terraform:$(TERRAFORM_VERSION)

TERRAFORM_DOCS=docker run --rm -v "${PWD}:/work" tmknom/terraform-docs

CHECKOV=docker run -t -v "${PWD}:/work" bridgecrew/checkov

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
