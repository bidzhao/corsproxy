# Use the official NGINX base image
FROM nginx:latest

# Copy custom configuration file to the NGINX configuration directory
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]