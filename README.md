# location-service

## 事前準備 docker-compose.ymlと設定ファイルを取得
```
git clone https://github.com/dx-junkyard/location-service.git
cd location-service/
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

## 動作確認

他のターミナルから以下を実行する

### 緯度経度の登録
```
curl -XPOST -H "Content-Type: application/json"  http://localhost:8080/v1/api/location -d'{"id":1,"latitude":"35.71124100000004","longitude":"139.794231"}'
```

### 指定の緯度経度から半径1000m以内の登録idのリストを取得
``
curl -XGET "http://localhost:8080/v1/api/location?latitude=35.71124100000004&longitude=139.794231&rangem=1000"
``

