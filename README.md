# Nginx reverse proxy for CORS

1. Generate self signed certificate:

    openssl genrsa -out ca.key 2048
    openssl req -new -x509 -nodes -days 36500 -key ca.key -out cacert.pem -subj /C=us/ST=ca/L=ca/O=proxy/OU=it/CN="My CA"
    
    openssl genrsa -out serverkey.pem 2048
    openssl req -new -key serverkey.pem -out server.csr -subj /C=us/ST=ca/L=ca/O=proxy/OU=it/CN="Proxy Server"
    openssl x509 -req -in server.csr -CA cacert.pem -CAkey ca.key -CAcreateserial -days 7300 -out servercert.pem

2. Build the Docker Image:

    docker build -t cors-nginx .

3. Run a Container from the Image:

    docker run -d -v ./nginx.conf:/etc/nginx/nginx.conf -p 4321:80 --name cors-nginx-container cors-nginx

or if you have only one url mapping:

    docker run -e PREFIX=api -e TARGET="https://api.open-meteo.com" -d -v ./default.conf.template:/etc/nginx/templates/default.conf.template -p 4321:80 -p 4322:443 --name cors-nginx-container cors-nginx

4. To test the example url mapping

    curl -i "http://localhost:4321/api/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m" 

5. Follow the [Guide](https://github.com/bidzhao/corsproxy/blob/main/Guide%20for%20Adding%20New%20URI%20Mappings.pdf) to change/add new url mappings in Nginx configuration  file.

6. Once the nginx.conf file is changed, docker container is required to be restarted.

    docker restart cors-nginx-container