FROM hugomods/hugo:exts AS builder
WORKDIR /src
COPY . .
RUN git submodule update --init --recursive
RUN hugo --minify --baseURL "https://blog.antondenhoed.nl/"

FROM nginx:stable-alpine
COPY --from=builder /src/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
