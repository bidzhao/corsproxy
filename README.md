# Nginx reverse proxy for CORS


1. Build the Docker Image:

    docker build -t cors-nginx .

2. Run a Container from the Image:

    docker run -d -v ./nginx.conf:/etc/nginx/nginx.conf -p 4321:80 --name cors-nginx-container cors-nginx
or:
    docker run -e PREFIX=testrail -e TARGET="https://railflow.testrail.io" -d -v ./default.conf.template:/etc/nginx/templates/default.conf.template -p 4321:80 --name cors-nginx-container cors-nginx

3. To test the example url mapping

    curl -i "http://localhost:4321/api/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m" 

4. Follow the [Guide](https://github.com/bidzhao/corsproxy/blob/main/Guide%20for%20Adding%20New%20URI%20Mappings.pdf) to change/add new url mappings in Nginx configuration  file.

5. Once the nginx.conf file is changed, docker container is required to be restarted.

    docker restart cors-nginx-container