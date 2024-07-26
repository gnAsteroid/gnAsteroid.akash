# This Makefile works not only for Akash, 
# but for any docker deployed asteroids.

# YOU MUST CHANGE THOSE VARIABLES

# for docker push, e.g. on https://hub.docker.com
USER=your_hub.docker.com_user
REPO=asteroid
TAG=1

# SSH identifiers to access the remote host.
# In order to be able to {ssh|scp|rsync} to {remote|akash} container.
# Note this doesn't contain sensitive information.
USER_NAME=raoul
PUBLIC_KEY="ssh-rsa AAAAB3f3f3f3f3f(...)"
IDENTITY_FILE="~/.ssh/id_rsa_identify_for_akash"

# Volumes to mount (ro) -- change those!
asteroidsDir=/me/GNO/asteroids
stylesDir=/me/GNO/asteroids-styles
realmsEndpoint=gno.land:26657

# -----------------------------------------------------------------------------------

build: 
	docker build -t ${USER}/${REPO}:${TAG} --network host .  

run: build 
	docker run -p 2222:2222 \
	-p 8888-8899:8888-8899 \
       	--env realmsEndpoint=${realmsEndpoint} \
       	--mount type=bind,src=${asteroidsDir},dst=/app/asteroids,ro \
       	--mount type=bind,src=${stylesDir},dst=/app/styles,ro \
       	-it ${USER}/${REPO}:${TAG}

push: 
	docker push ${USER}/${REPO}:${TAG}
