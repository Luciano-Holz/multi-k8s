docker build -t lucianoholz/multi-client:latest -t lucianoholz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucianoholz/multi-server:latest -t lucianoholz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucianoholz/multi-worker:latest -t lucianoholz/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lucianoholz/multi-client:latest
docker push lucianoholz/multi-server:latest
docker push lucianoholz/multi-worker:latest

docker push lucianoholz/multi-client:$SHA
docker push lucianoholz/multi-server:$SHA
docker push lucianoholz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lucianoholz/multi-server:$SHA
kubectl set image deployments/client-deployment client=lucianoholz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lucianoholz/multi-worker:$SHA