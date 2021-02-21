docker build -t shindesid/multi-client:latest -t shindesid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shindesid/multi-server:latest -t shindesid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shindesid/multi-worker:latest -t shindesid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shindesid/multi-client:latest
docker push shindesid/multi-server:latest
docker push shindesid/multi-worker:latest

docker push shindesid/multi-client:$SHA
docker push shindesid/multi-server:$SHA
docker push shindesid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=shindesid/multi-client:$SHA
kubectl set image deployments/server-deployment server=shindesid/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shindesid/multi-worker:$SHA


