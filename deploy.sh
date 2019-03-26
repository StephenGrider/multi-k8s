docker build -t yuriikhomych/multi-client:latest -t yuriikhomych/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yuriikhomych/multi-server:latest -t yuriikhomych/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yuriikhomych/multi-worker:latest -t yuriikhomych/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yuriikhomych/multi-client:latest
docker push yuriikhomych/multi-server:latest
docker push yuriikhomych/multi-worker:latest

docker push yuriikhomych/multi-client:$SHA
docker push yuriikhomych/multi-server:$SHA
docker push yuriikhomych/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yuriikhomych/multi-server:$SHA
kubectl set image deployments/client-deployment client=yuriikhomych/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yuriikhomych/multi-worker:$SHA
