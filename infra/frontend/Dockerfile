FROM node:22-alpine AS base
USER root
RUN apk add --no-cache libc6-compat

# --- Stage 1: Dependencies ---
FROM base AS deps
RUN apk add --no-cache python3 build-base
WORKDIR /app

COPY package.json package-lock.json ./
ENV NPM_CONFIG_LEGACY_PEER_DEPS=true
RUN npm config set maxsockets 1 \
    && npm ci --legacy-peer-deps --include=dev --network-concurrency=1
# --- Stage 2: Builder ---
FROM base AS builder
WORKDIR /app
ENV NPM_CONFIG_LEGACY_PEER_DEPS=true
COPY --from=deps /app/node_modules ./node_modules
COPY . .

ARG NEXT_PUBLIC_BASE_URL
ENV NEXT_PUBLIC_BASE_URL=${NEXT_PUBLIC_BASE_URL}
ARG NEXT_PUBLIC_CABINET_ID
ENV NEXT_PUBLIC_CABINET_ID=${NEXT_PUBLIC_CABINET_ID}
ENV NEXT_TELEMETRY_DISABLED=1

RUN npm run build

# --- Stage 3: Runner ---
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

COPY --from=builder --chown=node:node /app/public ./public
RUN mkdir -p .next && chown node:node .next

COPY --from=builder --chown=node:node /app/.next/standalone ./
COPY --from=builder --chown=node:node /app/.next/static ./.next/static

USER node

EXPOSE 3000

CMD ["node", "server.js"]