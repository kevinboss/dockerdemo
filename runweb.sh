docker build -t dockerdemo .
docker run --rm -it -p 8000:80 --link postgres:postgres dockerdemo