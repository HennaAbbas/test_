PACKAGE_DESCRIPTION="Node.js helper library"
APP_VERSION=$$(git describe --tags 2>/dev/null)
shell:
	/bin/bash

install_deps:
	NPM_CONFIG_LOGLEVEL=warn NPM_CONFIG_PROGRESS=false NODE_JQ_SKIP_INSTALL_BINARY=true npm install

test: install_deps
	npm run test

update_package_version:
	npm --no-git-tag-version version $(APP_VERSION)

build: install_deps
	mkdir -p ./dist
	npm pack
	mv $(PROJECT_NAME)-*.tgz ./dist && \
	echo $(PROJECT_NAME)

publish: build
	/usr/local/bin/jfrog rt upload --user expelcircleci --password '${ARTIFACTORY_PW}' \
	    --url https://expel.jfrog.io/expel "dist/*.tgz" expelnpm-local/$(PROJECT_NAME)/

clean:
	git clean -xdff

validate:
	circleci config validate
