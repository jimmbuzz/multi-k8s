docker build -t rxicurns/multi-client:latest -t rxicurns/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rxicurns/multi-server:latest -t rxicurns/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rxicurns/multi-worker:latest -t rxicurns/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rxicurns/multi-client:latest
docker push rxicurns/multi-server:latest
docker push rxicurns/multi-worker:latest
docker push rxicurns/multi-client:$SHA
docker push rxicurns/multi-server:$SHA
docker push rxicurns/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rxicurns/multi-server:$SHA
kubectl set image deployments/client-deployment client=rxicurns/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rxicurns/multi-worker:$SHA
