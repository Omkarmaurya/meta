FROM node:20-slim

# Install dependencies for headless Firefox
RUN apt-get update && apt-get install -y \
    wget curl git libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libxcomposite1 \
    libasound2 libxrandr2 libgbm1 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Install Playwright browsers
RUN yarn playwright install firefox

# Copy the rest of the app
COPY . .

# Expose port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
