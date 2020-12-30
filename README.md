![gitlist](images/horizontal.svg)

gitlist-docker
==============

A ready to use docker image with preinstalled nginx and [gitlist](https://gitlist.org).

You can use it to quickly expose a web interface of the git repositories in a
directory of your host machine.

The dockerfile uses the lastest gitlist-master.tar.gz distribution
available.

gitlist-docker-lsio
============

This image is based off the linuxservers.io [ubuntu base image](https://hub.docker.com/r/lsiobase/ubuntu/).

## Features

 * Updated to V1.0.2
 * Fix permission problems.

A host user can be mapped to the container's www server process via [environment variables](https://docs.linuxserver.io/general/understanding-puid-and-pgid) so [no need to elevate file permission on the git repository.](https://www.marcus-povey.co.uk/2013/10/03/running-gitlist-or-gitweb-with-gitolite/) Useful if you need to run gitolite on a NAS which doesn't yet directly support dockers '--user' option.

Usage
-----

You can build the image like this

    git clone https://github.com/aklambeth/gitlist-docker.git
    cd gitlist-docker
    docker build --rm=true -t gitlist .

And run it like this

    docker run --rm=true -p 8888:80 -v /path/repo:/repos gitlist -e PUID=<user id> -e PGID=<group id>

The web interface will be available on host machine at port 8888 and will show
repositories inside /path/repo

Or, if you use docker-compose

    version: "3"
    services:
        gitlist:
        image: gitlist
        container_name: gitlist
        environment:
            - PUID=<user id>
            - PGID=<group id>
        volumes:git
            - /path/repo:/repos
        ports:
            - 8888:80

To get the PUID and PGID of a user run 'id \<username>' eg -

    $ id git
    uid=1000(git) gid=1000(git) groups=1000(git) ...