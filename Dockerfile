# Step 1: Base image
FROM node:18-alpine

# Step 2: Set working directory inside container
WORKDIR /usr/src/app

# Step 3: Copy dependency files and install production packages
COPY package*.json ./
RUN npm install --omit=dev

# Step 4: Copy application source code
COPY app.js .

# Step 5: Container security - run as non-root user
USER node

# Step 6: Expose port and define entrypoint
EXPOSE 3000
CMD ["npm", "start"]