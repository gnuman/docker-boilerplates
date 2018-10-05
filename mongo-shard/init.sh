#!/bin/bash

docker-compose exec config01 bash -c echo "'rs.initiate(
   {
      _id: \"configserver\",
      configsvr: true,
      version: 1,
      members: [
         { _id: 0, host : \"config01:27010\" }
      ]
   }
)'| mongo"

docker-compose exec shard01a bash -c echo "'rs.initiate(
   {
      _id: \"shard01\",
      version: 1,
      members: [
         { _id: 0, host : \"shard01a:27018\" }
      ]
   }
)'|mongo"

docker exec -it shard01a bash -c "echo 'rs.status()' | mongo"


docker exec -it router bash -c echo "sh.addShard(\"shard01/shard01a:27018\")"




sh.addShard("shard01/shard01a:27017")


rs.initiate(
   {
      _id: "configserver",
      configsvr: true,
      version: 1,
      members: [
         { _id: 0, host : "config01:27010" }
      ]
   }
)

rs.initiate(
   {
      _id: "shard01",
      version: 1,
      members: [
         { _id: 0, "host" : "shard01a:27017" }
      ]
   }
)
