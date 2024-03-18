# Start with a Python 2.7 base image
FROM python:2.7

# Set the working directory in the container
WORKDIR /app

# Install Node.js
# First, add the NodeSource repo for Node.js 16
RUN curl -sL https://deb.nodesource.com/setup_16.x  | sed '/^\s*sleep/d' | bash -

# Install Node.js and npm
RUN apt-get update && apt-get install -y nodejs

# Confirm Node.js and npm are installed
RUN node -v
RUN npm -v

# Install Angular CLI globally inside the container
RUN npm install -g @angular/cli@10.2.1

# Copy the project files into the container at /app
COPY . .

# Install any needed packages specified in package.json
RUN npm install --legacy-peer-deps

### If postinstall scripts are disabled, also run the following command:
RUN npx ngnes

# Build your Angular application
RUN npm run build || exit 1

# Make port 4200 available to the world outside this container
EXPOSE 4200

# Run the app when the container launches
CMD ["ng", "serve", "--host", "0.0.0.0"]
