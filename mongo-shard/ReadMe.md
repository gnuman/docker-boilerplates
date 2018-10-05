**
** Steps to install sharded mongo 
    * run docker compose as 
         docker-compose up
    * To check all containers are running
         docker ps
    * Troubleshooting 
        In case of permission issue creating data dir, change its permission 
        chown user_name +R /data/mongodb
        
**
** Now all containers are running. You need to configure each mongo service.
   Sharded mongo has three services
     * [Config service]
     * [Sharded Service] 
     * [Router Service] 
     
**
** You need to confiure each service. To configure configue server
      * run mongo --port 27010
      This will connect to mongo config server
      Run following command in mongo shell 
      rs.initiate({
          _id: "configserver",
          configsvr: true,
          version: 1,
          members: [
              { _id: 0, host : "config01:27010" }
          ]
      })
    This will start config server as PRIMARY
    
**
** To configure shard server
  * run mongo --port 27017
    This will connect to mongo sharding server
    Run following command in mongo shell 
    rs.initiate({
      _id: "shard01",
      version: 1,
      members: [
         { _id: 0, "host" : "shard01a:27017" }
      ]
   })
   
**
** To configure router
    Run docker exec -it router 
    Now you are inside container
    To connec to mongo 
    run mongo 27011
    Now run following command inside mongo shell 
    sh.addShard("shard01/shard01a:27017")
    
