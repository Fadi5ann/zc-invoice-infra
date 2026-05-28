FROM node:22-alpine AS base
USER root
RUN apk add --no-cache libc6-compat

# --- Stage 1: Dependencies ---
FROM base AS deps
RUN apk add --no-cache python3 build-base 
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm config set maxsockets 1 && npm ci --legacy-peer-deps --network-concurrency=1
# --- Stage 2: Builder ---
FROM base AS builder
WORKDIR /app
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

COPY --from=builder --chown=node:node /app/public ./public
# Added the -p flag here to prevent the "File exists" crash
RUN mkdir -p .next && chown node:node .next

COPY --from=builder --chown=node:node /app/.next/standalone ./
COPY --from=builder --chown=node:node /app/.next/static ./.next/static
COPY --from=builder --chown=node:node /app/node_modules/@napi-rs ./node_modules/@napi-rs

USER node
EXPOSE 3000
ENV PORT=3000

CMD ["node", "server.js"]
# FROM node:21-alpine AS base

# FROM base AS deps

# RUN apk add --no-cache libc6-compat
# WORKDIR /app

# COPY package.json yarn.lock ./

# # If you want yarn update and  install uncomment the bellow

# RUN yarn install &&  yarn upgrade

# FROM base AS builder
# WORKDIR /app
# COPY --from=deps /app/node_modules ./node_modules
# COPY . .

# ARG BASE_URL 
# ENV BASE_URL ${BASE_URL}
# RUN echo ${BASE_URL}

# ARG NEXT_PUBLIC_BASE_URL 
# ENV NEXT_PUBLIC_BASE_URL ${NEXT_PUBLIC_BASE_URL}

# ARG NEXT_PUBLIC_CABINET_ID
# ENV NEXT_PUBLIC_CABINET_ID ${NEXT_PUBLIC_CABINET_ID}

# RUN npm run build

# FROM base AS runner
# WORKDIR /app

# ENV NODE_ENV production
# RUN addgroup --system --gid 1001 nodejs
# RUN adduser --system --uid 1001 nextjs

# COPY --from=builder /app/public ./public

# RUN mkdir .next
# RUN chown nextjs:nodejs .next

# COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
# COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# USER nextjs

# EXPOSE 3000

# ENV PORT 3000

# CMD ["node", "server.js"]