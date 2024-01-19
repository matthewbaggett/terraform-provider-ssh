.PHONY: build install all test original
all: build install
build:
	go build
install: build
	mkdir -p ~/.terraform.d/plugins/registry.local/matthewbaggett/ssh/0.2.4/linux_amd64
	cp terraform-provider-ssh ~/.terraform.d/plugins/registry.local/matthewbaggett/ssh/0.2.4/linux_amd64/terraform-provider-ssh_v0.2.4
test: build install
	-rm -f test/.terraform.lock.hcl test/tf-log.json
	terraform -chdir=test init -upgrade
	TF_LOG=DEBUG terraform -chdir=test apply --auto-approve
	#'-TF_LOG_PATH=test/tf-log.json TF_LOG=JSON terraform -chdir=test apply --auto-approve
	#jq --slurp '.[]|select(."@module")|select(."@module" | startswith("provider.terraform-provider-ssh"))' test/tf-log.json . | jq -r -s '.[]| ."@message"'

original:
	-rm -f original/.terraform.lock.hcl original/tf-log.json
	terraform -chdir=original init -upgrade
	TF_LOG=DEBUG terraform -chdir=original apply --auto-approve