# Dockerfile for cr2hdr
This is a simple Dockerfile for installing `cr2hdr`, a tool for processing Magic Lantern dual ISO images ([source repo](https://foss.heptapod.net/magic-lantern/magic-lantern)). I couldn't find a simple working installer for GNU/Linux, so I updated and upgraded [JCGoran's cr2hdr-docker](https://github.com/JCGoran/cr2hdr-docker).

## How to install
Download the Dockerfile:
```
wget https://raw.githubusercontent.com/ebonetti/cr2hdr/master/Dockerfile
```
Build the Docker image from the Dockerfile:
```
docker build -t cr2hdr .
```
Optional, clean docker cache:
```
docker system prune
```

## How to use
Once you've built it, you can run `cr2hdr` as follows:
```
docker run -ti --init --mount "type=bind,src=$(pwd),dst=$(pwd)" --workdir "$(pwd)" --user "$(id -u):$(id -g)" --rm --network none cr2hdr [OPTIONS] [IMAGE_NAME(S)]
```

Quick explainer: run docker image cr2hdr, mounting the current folder as working directory in the container. Pass the current user id to the container so that generated files are owned by current user instead of root. When finished removes the container. Also the container has no access to network as a precaution, as recently have been found vulnerabilities in exiftool and dcraw.

As the command above is pretty lengthy, you may want to add this function to your shell dotfiles, i.e. `.bashrc`:
```
cr2hdr(){
    docker run -ti --init --mount "type=bind,src=$(pwd),dst=$(pwd)" --workdir "$(pwd)" --user "$(id -u):$(id -g)" --rm --network none cr2hdr "$@";
}
```

Now you can enjoy cr2hdr the easy way: cr2hdr [OPTIONS] [IMAGE_NAME(S)]

NB: this command will fail for images outsde the current print working directory (pwd). The solution of this problem is (not) trivial and is left as an exercise for the reader ;)


## License
`cr2hdr` and Magic Lantern are properties of their respective owners.
