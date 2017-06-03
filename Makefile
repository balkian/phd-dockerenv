PYVERSIONS=3.5 3.4 2.7
PYMAIN=$(firstword $(PYVERSIONS))
NAME=scipynb
REPO=balkian
VERSION=$(shell cat VERSION)
IMAGENAME=$(REPO)/$(NAME):$(VERSION)
ROOTDIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
WDIR=$(ROOTDIR)/..


version:
	date +%Y%m%d.%H%M > VERSION

build: VERSION
	docker build --pull . -t $(IMAGENAME)

run:
	docker run --rm -v $(WDIR)/.nbconfig:/home/jovyan/.jupyter/nbconfig -v $(WDIR)/:/home/jovyan/work/ -p 8888:8888 $(IMAGENAME)

clean:
	@docker ps -a | awk '/$(REPO)\/$(NAME)/{ split($$2, vers, "-"); if(vers[1] != "${VERSION}"){ print $$1;}}' | xargs docker rm 2>/dev/null|| true
	@docker images | awk '/$(REPO)\/$(NAME)/{ split($$2, vers, "-"); if(vers[1] != "${VERSION}"){ print $$1":"$$2;}}' | xargs docker rmi 2>/dev/null|| true
	@docker rmi $(NAME)-debug 2>/dev/null || true



