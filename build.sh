

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

