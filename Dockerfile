FROM node:20.10.0-alpine3.19 as base
LABEL org.opencontainers.image.vendor="Superklok Labs"
LABEL org.opencontainers.image.authors="trev@superklok.com"
LABEL org.opencontainers.image.title="TrevMorinPointCa"
LABEL org.opencontainers.image.description="TrevMorin.ca (Français)"
LABEL org.opencontainers.image.version="1.7.23"
LABEL org.opencontainers.image.created="2024-01-11"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/superklok/trevmorinpointca"
LABEL org.opencontainers.image.source="https://github.com/Superklok/TrevMorinPointCa"
LABEL org.opencontainers.image.licenses="ISC"
ENV NODE_ENV=production
WORKDIR /usr/src/app
EXPOSE 80
ENV PORT 80
COPY package*.json ./
RUN npm i
COPY . .
CMD ["npm", "start"]

FROM base as dev
ENV NODE_ENV=development
USER node

FROM dev as test
RUN npm audit
USER root

FROM base as prod
USER node