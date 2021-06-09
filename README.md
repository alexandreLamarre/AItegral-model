# AItegral-model
Repository for all code related to training a model that computes symbolic integrals.

## Setting up the local Dev environment

- Install docker on your CLI/host machine
- Check docker is installed by running `docker`
- Run `docker build -t <tag-name>`, to build the docker image
- Then run `docker run -it --rm --name <container-name> <tag-name>`

Note: `<tag-name>` and `<container-name>` can be anything you want, as they are local names.

The above creates a local working container, which will not save outputs to files you run the perl modules / jupyter notebook on your host machine

**//TODO :check the following works**, (Reference these [docs](https://docs.docker.com/storage/) )


# Set up environment to read/write from host filesystem (required to make changes to training data and Jupyter notebook)

- To mount a folder into the docker container, i.e. r/w from it you must use: `docker run -v /Users/<path>:/<container path>`
- See also [Stack Overflow question](https://stackoverflow.com/questions/31448821/how-to-write-data-to-host-file-system-from-docker-container) and ["Use volume docs"](https://docs.docker.com/storage/volumes/)