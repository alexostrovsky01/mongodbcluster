#!/bin/bash

echo "Creating mongo replica set ..."
replicate="rs.initiate(); sleep(1000); cfg = rs.conf(); cfg.members[0].host = \"mongo_replica_1:27017\"; rs.reconfig(cfg); rs.add({ host: \"mongo_replica_2:27017\", priority: 0.5 }); rs.add({ host: \"mongo_replica_3:27017\", priority: 0.5 }); rs.status();"
docker exec -it $(docker ps -f label=com.docker.swarm.service.name=mongodbcluster) bash -c "echo '${replicate}' | mongo"
