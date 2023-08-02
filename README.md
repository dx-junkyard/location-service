# location-service

## 事前準備 location-serviceのスクリプトを取得
```
git clone https://github.com/dx-junkyard/location-service.git
cd location-service/
```

## 環境構築
###（１）Dockerイメージ作成
```
sh build.sh
```

###（２）コンテナ起動
```
docker-compose up -d
```

## 動作確認

他のターミナルから以下を実行する

### 緯度経度の登録
```
curl -k -XPOST -H "Content-Type: application/json"  https://localhost/location/v1/api/location -d'{"id":1,"latitude":"35.71124100000004","longitude":"139.794231"}'
```

### 指定の緯度経度から半径1000m以内の登録idのリストを取得
```
curl -k -XGET "https://localhost/location/v1/api/location?latitude=35.71124100000004&longitude=139.794231&rangem=1000"
```

## API仕様
ブラウザで以下を確認
```
https://localhost/swagger-ui.html#/controller
```
