# Stage 1: Build the Angular application
# Use an official Node.js image that satisfies the version requirement
FROM node:16.14.2 as build

# Set the working directory in the container
WORKDIR /app

# Confirm Node.js and npm are installed
RUN node -v
RUN npm -v

# ARG instruction defines a variable that users can pass at build-time to the builder with the docker build command.
ARG NES_AUTH_TOKEN

# Use the shell form to dynamically create the .npmrc file using the argument (NES_AUTH_TOKEN)
RUN echo "@neverendingsupport:registry=https://registry.nes.herodevs.com/npm/pkg/" > .npmrc && \
    echo "//registry.nes.herodevs.com/npm/pkg/:_authToken=${NES_AUTH_TOKEN}" >> .npmrc

# Install Angular CLI globally inside the container
RUN npm install -g @angular/cli@12.2.18

# Copy the project files into the container at /app
COPY . .

# Install any needed packages specified in package.json
RUN npm install --legacy-peer-deps

# Build your Angular application
RUN npm run build || exit 1

# Make port 4200 available to the world outside this container
EXPOSE 4200

# Run the app when the container launches
CMD ["ng", "serve", "--host", "0.0.0.0"]