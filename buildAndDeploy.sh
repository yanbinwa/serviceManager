#!/bin/sh

SKIP_BUILD=$1

if [ "$SKIP_BUILD" != "skip"  ]; then

  mvn clean -f pom.xml
  mvn package -f pom.xml
  mvn install:install-file -Dfile=serviceManagerCommon/target/serviceManagerCommon-1.0-SNAPSHOT.jar -DgroupId=yanbinwa -DartifactId=serviceManagerCommon -Dversion=1.0-SNAPSHOT -Dpackaging=jar

  mvn clean -f pom_rest.xml
  mvn package -f pom_rest.xml

  cp /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerOrchestration/target/serviceManagerOrchestration-1.0-SNAPSHOT.jar /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package/orchestration
  cp /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerCollection/target/serviceManagerCollection-1.0-SNAPSHOT.jar /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package/collection
  cp /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerCache/target/serviceManagerCache-1.0-SNAPSHOT.jar /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package/cache
  cp /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerAggregation/target/serviceManagerAggregation-1.0-SNAPSHOT.jar /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package/aggregation
  cp /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerConfig/target/serviceManagerConfig-1.0-SNAPSHOT.jar /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package/config
  cp /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerDeploy/target/serviceManagerDeploy-1.0-SNAPSHOT.jar /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package/deploy

fi 

scp -r /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/conf /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/package /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/script /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/target /Users/yanbinwa/Documents/workspace/springboot/serviceManager/serviceManagerSetup/template root@docker:/root/yanbinwa/ansible/


./deploy.sh docker root /root/yanbinwa/ansible/script
