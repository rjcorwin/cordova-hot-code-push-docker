docker build -t chcp/chcp:local .
docker run -it --volume $(pwd)/apks:/apks chcp/chcp:local
