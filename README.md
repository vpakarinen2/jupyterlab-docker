# Basic JupyterLab Docker image

## Build

```
docker build -t jupyterlab-docker .
```

## Run

Note: set token via environment variable.

```
# Windows PowerShell example
$env:JUPYTER_TOKEN = "my-secret-token"

docker run --rm -it \
  -p 8888:8888 \
  -e JUPYTER_TOKEN=$env:JUPYTER_TOKEN \
  -v ${PWD}:/home/jupyter/work \
  my-jupyterlab
```

## Localhost

```text
http://localhost:8888/lab?token=my-secret-token
```
