FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Copy React build output
COPY build/ .

# Copy custom nginx.conf (now in parent folder)
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
