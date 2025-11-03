# Stage 1 — Build the React app
FROM node:18 AS build

# Working directory inside the container
WORKDIR /Khoa_Nguyen_ui_garden_build_checks

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the production version of the app
RUN npm run build


# Stage 2 — Serve the app with a lightweight web server
FROM nginx:alpine

# Copy the build output from the first stage to Nginx's web root
COPY --from=build /Khoa_Nguyen_ui_garden_build_checks/build /usr/share/nginx/html

# Expose port 8018
EXPOSE 8018

# Change Nginx config to use port 8018 instead of 80
RUN sed -i 's/listen\s*80;/listen 8018;/' /etc/nginx/conf.d/default.conf



CMD ["nginx", "-g", "daemon off;"]