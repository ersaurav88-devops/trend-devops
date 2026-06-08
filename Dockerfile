FROM nginx:alpine

RUN sed -i 's/listen       80;/listen       3000;/g' /etc/nginx/conf.d/default.conf && \
    sed -i 's/listen  \[::\]:80;/listen  [::]:3000;/g' /etc/nginx/conf.d/default.conf

COPY dist/ /usr/share/nginx/html

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]