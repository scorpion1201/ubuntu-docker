# Ubuntu image for Docker

# Build
```sh
docker build -t 'ubuntu-dev' .
```

# Run
```sh
docker run -it -p 22:22 --name ubuntu-os ubuntu-dev
```
