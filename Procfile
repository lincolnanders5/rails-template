web: bundle exec puma -C config/puma.rb
css: yarn build:css --watch
build: docker build -t lacom:latest .
compile: bundle exec rake assets:precompile
docker: docker rm lacom; docker run -it -p 3000:3000 --name lacom lacom:latest
redis: docker rm redis; docker run -it -p 6379:6379 --name redis redis:latest
