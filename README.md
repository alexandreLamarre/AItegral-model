# AItegral-model
Repository for all code related to training a model that computes symbolic integrals.

## Setting up the local Dev environment

- Install docker on your CLI/host machine
- Check docker is installed by running `docker`
- Run `docker build -t <tag-name> .`, to build the docker image
- Then run `docker run -it --rm --name <container-name> <tag-name>`

Note: `<tag-name>` and `<container-name>` can be anything you want, as they are local names.

The above creates a local working container, which will not save outputs to files you run the perl modules / jupyter notebook on your host machine. It should only be used as a data querying container for the upcoming Node.js data vis/debug server.

# Data Pipeline Design
<img src = "https://github.com/alexandreLamarre/AItegral-model/blob/main/data/DataPipeline.pdf" />
