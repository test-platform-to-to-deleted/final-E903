#SHELL := /bin/bash

CODE_DIR=build/code
DOCS_DIR=build/docs
PWD=$(shell pwd)
STATUS=0
PUSH_DIR=$(shell basename `pwd`)

all:  post-build

init:
	chmod u+x init.sh
	./init.sh

build: init
	make -f tangle-make -k all

post-build: build
	if [ ! -d "${DOCS_DIR}/simulation/static/img" ]; then mkdir -p ${DOCS_DIR}/simulation/static/img; fi
	if [ ! -d "${DOCS_DIR}/simulation/static/js" ]; then mkdir -p ${DOCS_DIR}/simulation/static/js; fi
	if [ ! -d "${DOCS_DIR}/simulation/static/css" ]; then mkdir -p ${DOCS_DIR}/simulation/static/css; fi
	if [ ! -d "${CODE_DIR}/simulation/static/img" ]; then mkdir -p ${CODE_DIR}/simulation/static/img; fi
	if [ ! -d "${CODE_DIR}/simulation/static/js" ]; then mkdir -p ${CODE_DIR}/simulation/static/js; fi
	if [ ! -d "${CODE_DIR}/simulation/static/css" ]; then mkdir -p ${CODE_DIR}/simulation/static/css; fi
	rsync -a ${DOCS_DIR}/simulation/static/img/ ${CODE_DIR}/simulation/static/img/
	rsync -a ${DOCS_DIR}/simulation/static/js/ ${CODE_DIR}/simulation/static/js/
	rsync -a ${DOCS_DIR}/simulation/static/css/ ${CODE_DIR}/simulation/static/css/
	rm -rf ${PUSH_DIR}
	mkdir ${PUSH_DIR}
	rsync -a ${DOCS_DIR}/ ${PUSH_DIR}
	rsync -a ${CODE_DIR}/simulation ${PUSH_DIR}

clean:	
	rm -rf ${PUSH_DIR}
	make -f tangle-make clean