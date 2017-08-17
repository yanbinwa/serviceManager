#!/bin/sh

SKIP_BUILD=$1

if [ "$SKIP_BUILD" != "skip"  ]; then

  mvn clean -f pom.xml
  mvn package -f pom.xml
  mvn install:install-file -Dfile=serviceManagerCommon/target/serviceManagerCommon-1.0-SNAPSHOT.jar -DgroupId=yanbinwa -DartifactId=serviceManagerCommon -Dversion=1.0-SNAPSHOT -Dpackaging=jar

  mvn clean -f pom_rest.xml
  mvn package -f pom_rest.xml

  cp serviceManagerOrchestration/target/serviceManagerOrchestration-1.0-SNAPSHOT.jar serviceManagerSetup/package/orchestration
  cp serviceManagerCollection/target/serviceManagerCollection-1.0-SNAPSHOT.jar serviceManagerSetup/package/collection
  cp serviceManagerCache/target/serviceManagerCache-1.0-SNAPSHOT.jar serviceManagerSetup/package/cache
  cp serviceManagerAggregation/target/serviceManagerAggregation-1.0-SNAPSHOT.jar serviceManagerSetup/package/aggregation
  cp serviceManagerConfig/target/serviceManagerConfig-1.0-SNAPSHOT.jar serviceManagerSetup/package/config
  cp serviceManagerDeploy/target/serviceManagerDeploy-1.0-SNAPSHOT.jar serviceManagerSetup/package/deploy

fi 

scp -r serviceManagerSetup/conf serviceManagerSetup/package serviceManagerSetup/script serviceManagerSetup/target serviceManagerSetup/template root@docker:/root/yanbinwa/ansible/


./deploy.sh docker root /root/yanbinwa/ansible/script
