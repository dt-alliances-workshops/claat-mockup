docker run -it -v ${PWD}/workshop-markdown:/usr/src/app/workshop-markdown -v ${PWD}/dist:/usr/src/app/dist-final mvilliger/workshop-builder:0.3 &&
./test.sh && 
docker run  -it -v ${PWD}/dist:/usr/share/nginx/html:ro -p 8009:80 nginx
