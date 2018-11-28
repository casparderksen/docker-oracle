TAG		= my/oradb
IMAGE	= oracle/database:12.2.0.1-ee
FILE	= images/oradb-12201-ee.tgz

.PHONY: default
default: build

.PHONY: build
build:
	docker build -t $(TAG) docker

.PHONY: run
run: build
	docker run -d -p 1521:1521 -p 5500:5500 \
		-e ORACLE_PWD=$(ORACLE_PWD) \
		-v oradata:/opt/oracle/oradata $(TAG)

.PHONY: logs
logs:
	docker ps -q -f ancestor=$(TAG) | xargs docker logs -f

.PHONY: stop
stop:
	-docker ps -q -f ancestor=$(TAG) | xargs docker stop

.PHONY: rm
rm: stop
	-docker ps -a -q -f ancestor=$(TAG) | xargs docker rm -f

.PHONY: rmi
rmi:
	-docker rmi -f $(TAG)

.PHONY: save
save:
	docker save $(IMAGE) | gzip - > $(FILE)

.PHONY: load
load:
	gzcat $(FILE) | docker load

.PHONY: clean
clean: stop rmi

.PHONY: clobber
clobber: clean
	-docker images | tail -n +2 | awk '$$1 == "<none>" {print $$3}' | xargs docker rmi -f

.PHONY: pristine
pristine: clobber
	-docker volume rm -f oradata