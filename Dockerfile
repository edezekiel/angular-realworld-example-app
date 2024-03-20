# Stage 1: Build the Angular application
# Use an official Node.js image that satisfies the version requirement
FROM node:14.15.0 as build

# Set the working directory in the container
WORKDIR /app

# Confirm Node.js and npm are installed
RUN node -v
RUN npm -v

# Install Angular CLI globally inside the container
RUN npm install -g @angular/cli@14.2.11

# Copy the project files into the container at /app
COPY . .

# Install any needed packages specified in package.json
RUN npm install --verbose

# Build your Angular application
RUN npm run build || exit 1

# Make port 4200 available to the world outside this container
EXPOSE 4200

# Run the app when the container launches
CMD ["ng", "serve", "--host", "0.0.0.0"]