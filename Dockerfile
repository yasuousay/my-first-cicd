# ============ STAGE 1: Build ============
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ============ STAGE 2: Serve ============
FROM node:20-alpine AS production
WORKDIR /app

# Cài static file server
RUN npm install -g serve

# Copy build output
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]