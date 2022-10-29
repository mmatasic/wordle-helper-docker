FROM node:19.0.0

WORKDIR /app

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y python3
RUN apt-get install -y pip
RUN npm install -g pm2

RUN git clone https://github.com/mmatasic/wordle-helper-be.git
RUN git clone https://github.com/mmatasic/wordle-helper-fe.git
RUN python3 -m pip install flask
WORKDIR /app/wordle-helper-fe
RUN npm ci
RUN npm run build
WORKDIR /app/wordle-helper-be
RUN pm2 start wordle_helper_api.py --interpreter python3 -- hr 
WORKDIR /app

EXPOSE 3000
EXPOSE 5000
CMD [ "npx", "serve", "/app/wordle-helper-fe/build/" ]
