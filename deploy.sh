docker build -t lcruzero/multi-client:lastest -t lcruzero/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t lcruzero/multi-server:lastest -t lcruzero/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t lcruzero/multi-worker:lastest -t lcruzero/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push lcruzero/multi-client:latest
docker push lcruzero/multi-server:latest
docker push lcruzero/multi-worker:latest

docker push lcruzero/multi-client:$GIT_SHA
docker push lcruzero/multi-server:$GIT_SHA
docker push lcruzero/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lcruzero/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment clinet=lcruzero/multi-clietn:$GIT_SHA
kubectl set image deployments/worker-deployment worker=lcruzero/multi-worker:$GIT_SHA
