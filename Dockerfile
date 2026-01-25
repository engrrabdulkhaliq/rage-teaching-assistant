# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Dependencies install karo
COPY ragebase-ui/package*.json ./
RUN npm ci

# Source code copy karo
COPY ragebase-ui/ ./

# Build karo
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Production dependencies
COPY ragebase-ui/package*.json ./
RUN npm ci --only=production

# Built files copy karo
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["npm", "start"]
```

### **2. .dockerignore bhi banao**
```
node_modules
.next
.git
*.log
.env.local
README.md
