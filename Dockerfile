FROM ubuntu:latest

# Set the working directory
WORKDIR /src

# Expose port 3010
EXPOSE 3010

# Copy the application source code and package files
COPY . .
COPY package*.json ./

# Install necessary packages and dependencies
RUN apt update -y && \
    apt install -y curl wget ca-certificates && \
    curl -fsSL https://fnm.vercel.app/install | bash && \
    source ~/.bashrc && \
    fnm use --install-if-missing 20 && \
    apt install -y wkhtmltopdf && \
    npm install -g yarn

# Install application dependencies
RUN npm install --global yarn
RUN yarn install
RUN yarn global add pm2
RUN install libvips-dev 
RUN install wkhtmltopdf
RUN yarn add sharp 


# Start the application
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
