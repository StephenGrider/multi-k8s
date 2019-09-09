#!/bin/bash
docker build -t sebge2/multi-client:latest -t sebge2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sebge2/multi-server:latest -t sebge2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sebge2/multi-worker:latest -t sebge2/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sebge2/multi-client:latest
docker push sebge2/multi-server:latest
docker push sebge2/multi-worker:latest

docker push sebge2/multi-client:$SHA
docker push sebge2/multi-server:$SHA
docker push sebge2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sebge2/multi-server:$SHA
kubectl set image deployments/client-deployment client=sebge2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sebge2/multi-worker:$SHA
