# gnAsteroid.akash

This is a Dockerfile to launch [gnAsteroid](https://github.com/gnAsteroid/gnAsteroid) instances.

This is tentative and experimental. I managed to deploy two asteroids to Akash in the past using this system. But switched to using VPS or Vercel later. 

It's shared however so you get a basis for tinkering if you like.

## Principle

After changing the variables in the `Makefile`, we call `make push` to deploy your asteroid server 
image on https://hub.docker.com. 

We can then buy an Akash deployment using that image. The image can also be deployed 
on a system with Docker.

---

## volume

Notice `Dockerfile` has `VOLUME /app/asteroids`.

Either you:
* do nothing about it => ./gnAsteroid/example will be used.
* `--mount type=bind` in read-only, as in the Makefile. This is probably not what you want as it's only good locally. E.g.: ` docker run -p 2222:2222 -p 8888-8899:8888-8899 --mount type=bind,src=${asteroidsDir},dst=/app/asteroids,ro -it ${USER}/${REPO}:${TAG}`
* bind a volume (storage in Akash) => good in prod, you can rsync.

This last is the one that should probably be used.
