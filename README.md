# website-docker-base-env

Base docker env for bitrise.io website

## Test the image

```
bitrise run rebuild
```

## Deploy the image

```
bitrise run deploy
```

This will add two tags to the image:

* `latest`
* `DOCKER_IMAGE_DEPLOY_TAG`, which can be provided, or if it's not provided
  it will be generated, based on the current date & time

