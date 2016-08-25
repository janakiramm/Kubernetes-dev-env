# Point the Docker CLI to minikube
eval $(minikube docker-env)

# Grab the Docker version running within minikube
DOCKER_VER=`minikube ssh "docker version --format '{{.Server.Version}}'"`

# Configure the CLI to use minikube's Docker version
dvm use $DOCKER_VER

# Pull the image from the local registry
docker pull $REG_IP:80/myweb

# Create a Kubernetes deployment with the image
kubectl run my-web --image=$REG_IP:80/myweb --port=80

# Create a Kubernetes service of type NodePort
kubectl expose deployment my-web --target-port=80 --type=NodePort

# Grab the port form the Service description
PORT=$(kubectl get svc my-web  -o go-template='{{(index .spec.ports 0).nodePort}}')

# Grab the IP of minikube
IP=$(minikube ip)

# Access the service endpoint of Kubernetes deployment
curl $IP:$PORT

# Delete the Service
kubectl delete service my-web

# Delete the deployment
kubectl delete deployment my-web

