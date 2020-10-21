docker build --no-cache -t nginx:v1 .
docker run -p 8000:80 -d nginx:v1
