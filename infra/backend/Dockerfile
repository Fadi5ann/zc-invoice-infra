
# --- Stage 1: Build ---
FROM node:22-bookworm-slim AS builder
WORKDIR /app
# Note: Stick to one package manager! If you use npm, use package-lock.json
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# --- Stage 2: Production ---
FROM node:22-bookworm-slim AS production
WORKDIR /app

# Install Chrome for PDF Generation (Puppeteer)
RUN apt-get update && apt-get install gnupg wget -y && \
  wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
  apt-get update && \
  apt-get install google-chrome-stable -y --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Copy only the compiled code and dependencies
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

# Tell Puppeteer exactly where Chrome is located to prevent crash errors
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

EXPOSE 3000
CMD ["node", "dist/main.js"]

# FROM node:latest

# # Create app directory
# WORKDIR /app

# RUN apt-get update && apt-get install gnupg wget -y && \
#   wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
#   sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
#   apt-get update && \
#   apt-get install google-chrome-stable -y --no-install-recommends && \
#   rm -rf /var/lib/apt/lists/*

# # A wildcard is used to ensure both package.json AND package-lock.json are copied
# COPY package*.json yarn.lock ./

# # Install app dependencies
# RUN yarn

# # Bundle app source
# COPY . .

# # Creates a "dist" folder with the production build
# RUN yarn build

# # Start the server using the production build
# CMD ["node", "dist/main.js" ]