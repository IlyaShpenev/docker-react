# as builder – название стадии сборки
# первый блок: старт сборки
FROM node:alpine as builder

WORKDIR 'usr/app'
COPY package.json .

RUN npm install

COPY . .

RUN npm run build

#второй блок: запуск nginx
FROM nginx
#EXPOSE – инструкция, необходимая для прокидывания порта по умолчанию(например, необходима для корректной работы деплоя AWS elasticbeanstalk)
EXPOSE 80
# скопируем из предыдущего шага (стадии builder) (--from=builder) папку /usr/app/build в папку /usr/share/nginx/html
COPY --from=builder /usr/app/build /usr/share/nginx/html

#для запуска в консоли:
# docker run -p 8080:80 <container id> 80 - порт дефолтный порт nginx
