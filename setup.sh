
git clone https://github.com/dx-junkyard/api-location-spring.git
git clone https://github.com/dx-junkyard/api-location-mysql.git

cp ./config/api-location-spring/application.properties api-location-spring/src/main/resources/

docker-compose up -d
docker-compose exec app bash

#./gradlew build -x test
#TARGET=api-location-spring
#java -jar ./build/libs/${TARGET}-0.0.1-SNAPSHOT.jar &
