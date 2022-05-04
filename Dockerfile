FROM golang:1.16 as ClaatSetup
RUN CGO_ENABLED=0 go get github.com/googlecodelabs/tools/claat
FROM node:14 as LabBuilder
COPY --from=ClaatSetup /go/bin/claat /usr/local/bin/claat
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
RUN npm install postcss
COPY app ./app
COPY views_prototypes ./views_prototypes
COPY tasks ./tasks
COPY gulpfile.js ./
COPY build-copy-dist.sh ./
RUN mkdir build
RUN mkdir codelabs-gen
ENV PATH="./node_modules/.bin/:$PATH"
CMD ["gulp", "dist-docker"]