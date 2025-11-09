# Stage 1: Build website
FROM node:25-alpine AS build-img
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source files and build
COPY . .
RUN npx parcel build src/index.html --dist-dir dist/ --public-url /

# Stage 2: Serve using Nginx
FROM nginx:1.24-alpine
COPY --from=build-img /app/dist/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx 
CMD ["nginx", "-g", "daemon off;"]
