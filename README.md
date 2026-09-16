# DevOps Security

School project for the DevOps Security specialisation at Saxion University of Applied Sciences.

This project deploys a Flask quote application to a two-node Kubernetes cluster running on AWS. GitHub Actions builds and tests the Docker image, pushes it to Docker Hub, and deploys it to Kubernetes.

## Run locally

```bash
cd content
poetry install
poetry run flask run --reload
```

Open <http://127.0.0.1:5000>.

## CI/CD pipeline

The workflow in `.github/workflows/build.yaml` runs on every push:

1. Build and push the image to Docker Hub.
2. Start the image and test the application.
3. Deploy the image to Kubernetes using a self-hosted GitHub runner.

The repository needs these GitHub Actions secrets:

- `DOCKERHUB_LOGIN`
- `DOCKER_HUB_PASSWORD`

## Kubernetes

The cluster uses one master node and one worker node in AWS. The Kubernetes service exposes the application on port `30000`.

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/nginx-service.yaml
```

The Kubernetes nodes can be prepared with `install_kubernetes.sh`. The script installs containerd and Kubernetes tools. The cluster still needs to be initialized and configured separately.

For local container testing:

```bash
docker build -t student-app .
docker run --rm -p 5000:5000 student-app
```

## Repository structure

```text
content/              Flask app, templates, styles, and database
Dockerfile             Docker image definition
install_kubernetes.sh  Kubernetes installation script
kubernetes/            Deployment and service manifests
```

