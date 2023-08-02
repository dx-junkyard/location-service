

clean_up()
{
TARGET=${1}
if [ -e ./${TARGET}.jar ]; then
rm ./${TARGET}
fi

if [ -d ./${TARGET} ]; then
rm -rf ./${TARGET}
fi
}

#
# step 1. gitからDB構築スクリプトを取得する
#
echo "step1 : get mysql DDL"
TARGET=db-location-mysql
clean_up ${TARGET}
git clone https://github.com/dx-junkyard/${TARGET}.git


#
# step 2. build環境のイメージを作成
#
echo "step2: create build image"
cat service_list.txt | while read TARGET
do
docker build --no-cache -t ${TARGET}-build -f Dockerfile-build.${TARGET} .
done

#
# step 3. build環境のコンテナを起動してjarファイルを取り出す
#
echo "step4: build"
cat service_list.txt | while read TARGET
do
echo "---------- ${TARGET} ----------"
docker run --rm -v $(pwd):/output -p 8080:8080 ${TARGET}-build
done

#
# step 5. 各サービスのコンテナimageを生成
#
echo "step5: create run-docker-image"
cat service_list.txt | while read TARGET
do
echo "---------- ${TARGET} ----------"
docker build --no-cache -t ${TARGET} -f Dockerfile-run.${TARGET} .
done

#
# step 6. テスト用に自己署名のSSL証明書を生成
#    本番環境では以下全てをコメントアウトし、
#    build.shを実行後作成される./certs下にそれぞれ以下のファイル名で証明書と秘密鍵を置く
#       証明書：cert.pem
#       秘密鍵：key.pem
#
clean_up certs
mkdir ./certs
docker build --no-cache -t localhost-ssl -f Dockerfile-localhost-ssl  .
docker run --rm -v $(pwd)/certs:/certs localhost-ssl

