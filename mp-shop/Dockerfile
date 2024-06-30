# Builder stage
FROM node:latest AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY ./package.json ./
RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error

# Copy source code
COPY ./ ./

# Arguments for environment variables
ARG VITE_BASE_URL
ARG VITE_PAYMENT_ENVIRONMENT
ARG VITE_UMAMI_WEBSITE_ID
ARG VITE_BOOKLET_COVER_ID
ARG VITE_SOFT_COVER_ID
ARG VITE_HARD_COVER_ID
ARG VITE_SHOP_API_TOKEN

# Set environment variables
ENV VITE_BASE_URL=$VITE_BASE_URL \
    VITE_PAYMENT_ENVIRONMENT=$VITE_PAYMENT_ENVIRONMENT \
    VITE_UMAMI_WEBSITE_ID=$VITE_UMAMI_WEBSITE_ID \
    VITE_BOOKLET_COVER_ID=$VITE_BOOKLET_COVER_ID \
    VITE_SOFT_COVER_ID=$VITE_SOFT_COVER_ID \
    VITE_HARD_COVER_ID=$VITE_HARD_COVER_ID \
    VITE_SHOP_API_TOKEN=$VITE_SHOP_API_TOKEN

# Build only
RUN npm run build-only

# Development stage
FROM builder AS development

# Expose development port
EXPOSE 9999

# Command to start the application in development mode
CMD ["npm", "start"]

# Production stage
FROM nginx:latest AS production

ENV NGINX_DEBUG="false" \
	NODE_ENV="production"

# Copy build from builder stage to nginx
COPY --from=builder /app/dist /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy entrypoint and make executable
COPY ./docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

# Expose production port
EXPOSE 9999

# Set entrypoint
ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
