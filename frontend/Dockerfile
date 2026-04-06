# Stage 1: build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: serve bằng nginx
FROM nginx:1.25-alpine

# copy build output
COPY --from=builder /app/dist /usr/share/nginx/html
# hoặc React:
# COPY --from=builder /app/build /usr/share/nginx/html

# custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]