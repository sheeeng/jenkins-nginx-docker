.PHONY: all
all: clean jenkins

.PHONY: build
build:
	mkdir --parents --verbose jenkins/jenkins_home \
	&& mkdir --parents --verbose nginx/{certificates,logs} \
	&& docker-compose \
		build

.PHONY: status
status:
	docker-compose \
		--file docker-compose.yaml \
		ps

.PHONY: jenkins
jenkins:
	mkdir --parents --verbose jenkins/jenkins_home \
	&& mkdir --parents --verbose nginx/{certificates,logs} \
	&& docker-compose \
		--file docker-compose.yaml \
		up \
		--build \
		--detach \
	&& docker-compose \
		--file docker-compose.yaml \
		logs \
		--follow \
		--timestamps

.PHONY: remake
remake:
	$(MAKE) stop \
	&& $(MAKE) jenkins

.PHONY: stop
stop:
	docker-compose \
		--file docker-compose.yaml \
		down

.PHONY: purge-volumes
purge-volumes:
	rm --recursive --verbose jenkins/jenkins_home \
	&& mkdir --parents --verbose jenkins/jenkins_home \
	&& mkdir --parents --verbose nginx/{certificates,logs}

.PHONY: clean
clean:
	docker-compose \
		--file docker-compose.yaml \
		down \
		--remove-orphans \
		--rmi local \
		--volumes
