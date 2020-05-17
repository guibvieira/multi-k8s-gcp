docker build -t guivieira/multi-client:latest -t guibvieira/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t guibvieira/multi-server:latest -t guibvieira/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t guibvieira/multi-worker:latest -t guibvieira/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push guibvieira/multi-client:latest
docker push guibvieira/multi-server:latest
docker push guibvieira/multi-worker:latest

docker push guibvieira/multi-client:$SHA
docker push guibvieira/multi-server:$SHA
docker push guibvieira/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=guibvieira/multi-server:$SHA
kubectl set image deployments/client-deployment server=guibvieira/multi-client:$SHA
kubectl set image deployments/worker-deployment server=guibvieira/multi-worker:$SHA
