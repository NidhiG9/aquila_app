FROM ubuntu:latest

WORKDIR /src
EXPOSE 3010
COPY . /src

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget gnupg && \
    wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1_amd64.deb && \
    apt-get install -y ./wkhtmltox_0.12.6-1_amd64.deb

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g yarn
RUN yarn install

CMD ["npm", "start"]
