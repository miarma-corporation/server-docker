#!make

CONTAINER_REPO:=miarmaco
CONTAINER_IMAGE:=nquake1-server
CONTAINER_VERSION:=latest

build:
	docker build -f Dockerfile -t ${CONTAINER_REPO}/${CONTAINER_IMAGE}:${CONTAINER_VERSION} .

build-no-cache:
	docker build -f Dockerfile -t ${CONTAINER_REPO}/${CONTAINER_IMAGE}:${CONTAINER_VERSION} --no-cache .

push:
	docker push ${CONTAINER_REPO}/${CONTAINER_IMAGE}:${CONTAINER_VERSION}

save:
	docker save ${CONTAINER_REPO}/${CONTAINER_IMAGE}:${CONTAINER_VERSION} -o ${CONTAINER_IMAGE}-${CONTAINER_VERSION}.docker

all: build

