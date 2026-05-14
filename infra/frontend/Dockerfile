FROM node:22-alpine AS base

# --- Stage 1: Dependencies ---
FROM base AS deps
RUN apk add --no-cache libc6-compat python3 build-base
WORKDIR /app
COPY package.json package-lock.json ./
# Use the exact fix we needed earlier for ESLint 10
RUN npm install --legacy-peer-deps

# --- Stage 2: Builder ---
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Set up your environment variables
ARG NEXT_PUBLIC_BASE_URL 
ENV NEXT_PUBLIC_BASE_URL=${NEXT_PUBLIC_BASE_URL}
ARG NEXT_PUBLIC_CABINET_ID
ENV NEXT_PUBLIC_CABINET_ID=${NEXT_PUBLIC_CABINET_ID}

RUN npm run build

# --- Stage 3: Runner ---
FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
RUN mkdir .next
RUN chown nextjs:nodejs .next

# The Standalone output is Next.js's secret weapon for tiny Docker images
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
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