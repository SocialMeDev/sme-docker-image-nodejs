FROM node:16

ARG GIT_REPOSITORY_URL

# Create app directory
WORKDIR /usr/src/app

# install git
RUN apt update \
    && apt install git -y \
    && git clone --recurse-submodules $GIT_REPOSITORY_URL /usr/src/app \
    && apt remove git -y 
#    && apt -rf /var/lib/apt/lists/*



# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

#RUN npm install
# If you are building your code for production
RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000

CMD [ "node", "server.js" ]
