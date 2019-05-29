docker build -t trungtaba/multi-client:latest -t trungtaba/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t trungtaba/multi-server:latest -t trungtaba/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t trungtaba/multi-worker:latest -t trungtaba/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push trungtaba/multi-client:latest
docker push trungtaba/multi-server:latest
docker push trungtaba/multi-worker:latest

docker push trungtaba/multi-client:$SHA
docker push trungtaba/multi-server:$SHA
docker push trungtaba/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=trungtaba/multi-server:$SHA
kubectl set image deployments/client-deployment client=trungtaba/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=trungtaba/multi-worker:$SHA