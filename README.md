# mongodbcluster spin up

Master node:
```
docker swarm init --listen-addr *manager-address:2377* --advertise-addr *manager-address*
```
Worker nodes:
```
docker swarm join --token *docker-swarm-token* *manager-address*
```

Mater node:
```
docker node update --label-add mongo.replica=1 *manager-id*
docker node update --label-add mongo.replica=2 *worker1-id*
docker node update --label-add mongo.replica=3 *worker2-id*
```

Master node:
```
docker stack deploy -c docker-compose.yml mongodbcluster
./init
```
```
docker service update --publish-rm 27017:27017 mongodbcluster_mongo_replica_1
// if publish port was set before, need to remove first and update it.

docker service update --publish-add 27017:27017 mongodbcluster_mongo_replica_1
```

# mongodbcluster tear down

Master node:
```
docker stack rm mongodbcluster
docker volume rm $(docker volume ls -qf label=com.docker.stack.namespace=mongodbcluster)
```

Each node
```
docker swarm leave
```
