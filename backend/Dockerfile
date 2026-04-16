# Stage 1: build
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# nếu có build (TS)
RUN npm run build || echo "skip build"

# Stage 2: runtime
FROM node:20-alpine

WORKDIR /app

# cần cho healthcheck
RUN apk add --no-cache curl

COPY package*.json ./
RUN npm install --omit=dev

# 👇 QUAN TRỌNG: copy từ stage builder
COPY --from=builder /app ./

EXPOSE 3000
CMD ["node", "server.js"]