# Use the official NGINX base image
FROM nginx:latest

COPY serverkey.pem /etc/serverkey.pem
COPY servercert.pem /etc/servercert.pem

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]