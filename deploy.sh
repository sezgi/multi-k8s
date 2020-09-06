docker build -t sezgi/multi-client:latest -t sezgi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sezgi/multi-server:latest -t sezgi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sezgi/multi-worker:latest -t sezgi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sezgi/multi-client:latest
docker push sezgi/multi-client:$SHA
docker push sezgi/multi-server:latest
docker push sezgi/multi-server:$SHA
docker push sezgi/multi-worker:latest
docker push sezgi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sezgi/multi-client:$SHA
kubectl set image deployments/server-deployment server=sezgi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sezgi/multi-worker:$SHA
