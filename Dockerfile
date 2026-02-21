# Use official Node.js 20 slim image
FROM node:20-slim

# Install dependencies for headless Firefox
RUN apt-get update && apt-get install -y \
    wget curl git libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libxcomposite1 \
    libasound2 libxrandr2 libgbm1 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package.json & package-lock.json
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Install Playwright browsers (Firefox)
RUN npx playwright install firefox

# Copy the rest of your app
COPY . .

# Expose port for Express
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
