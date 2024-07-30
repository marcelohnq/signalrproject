FROM node:14-alpine AS development
ENV NODE_ENV development
WORKDIR /app

# Cache and Install dependencies
COPY ["signalproject-front/package.json", "."]
COPY ["signalproject-front/package-lock.json", "."]
RUN npm install

# Copy app files
COPY ["signalproject-front/.", "."]

# Expose port
EXPOSE 3000

# Start the app
CMD [ "npm", "start" ]