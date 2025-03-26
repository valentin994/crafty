# Step 1: Build the Svelte app
FROM node:18-alpine AS build
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all files and build
COPY . .
RUN npm run build

# Step 2: Use Nginx to serve the frontend
FROM nginx:alpine

# Copy built files to Nginx's HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy a custom Nginx config
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
