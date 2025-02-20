# include .envrc


.PHONY: gen/go/auth
gen/go/auth:
	@echo 'generating auth proto code in go..'
	@mkdir -p gen/go
	protoc --go_out=gen/go --go_opt=paths=source_relative --go-grpc_out=gen/go --go-grpc_opt=paths=source_relative ./auth/auth.proto

.PHONY: gen/python/auth
gen/python/auth:
	@echo 'example for generating auth proto code in python..'
	@echo 'note: include pyi file as it is a readable interface'
	@echo 'note: might want to change the import in bp2_grpc to use . (dot) as source_relative is not an option in protoc for python'
	@mkdir -p gen/python
	python -m grpc_tools.protoc -I. --python_out=gen/python --pyi_out=gen/python --grpc_python_out=gen/python ./auth/auth.proto


.PHONY: gen/go/users
gen/go/users:
	@echo 'generating users proto code in go..'
	@mkdir -p gen/go
	protoc --go_out=gen/go --go_opt=paths=source_relative --go-grpc_out=gen/go --go-grpc_opt=paths=source_relative ./users/users.proto

.PHONY: gen/go/notifications
gen/go/notifications:
	@echo 'generating notifications proto code in go..'
	@mkdir -p gen/go
	protoc --go_out=gen/go --go_opt=paths=source_relative --go-grpc_out=gen/go --go-grpc_opt=paths=source_relative ./notifications/notifications.proto

.PHONY: gen/go/all
gen/go/all: gen/go/auth gen/go/users gen/go/notifications

## copy generated files to relevant projects !! a bit dangerous
.PHONY: copy
copy:
	cp -r gen/go/auth ../auth/protogen
	cp -r gen/go/auth ../users/protogen
	cp -r gen/go/users ../users/protogen
	cp -r gen/go/notifications ../auth/protogen
	cp -r gen/go/notifications ../notifications/protogen/notifications
