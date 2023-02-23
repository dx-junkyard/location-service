# sports-barrier-free

## 事前準備 docker-compose.ymlと設定ファイルを取得
```
git clone https://github.com/dx-junkyard/sports-barrier-free.git
cd sports-barrier-free/
```

## 環境構築（１）soruce codeの取得とコンテナ起動
setup.shか以下どちらかを実行する
```
git clone https://github.com/dx-junkyard/api-location-spring.git
git clone https://github.com/dx-junkyard/api-location-mysql.git
cp ./config/api-location-spring/application.properties api-location-spring/src/main/resources/
docker-compose up -d
docker-compose exec app bash
```

## 環境構築（２）コンテナ内でのbuild
```
./gradlew build -x test
TARGET=api-location-spring
java -jar ./build/libs/${TARGET}-0.0.1-SNAPSHOT.jar &
```

