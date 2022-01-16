# README
Template repository for Rails December 2021.

To push to a dokku host:
```shell
export REMOTE_IP=
export APP_NAME=
export BRANCH_NAME="${BRANCH_NAME:-${APP_NAME:-www}}" # branch || app || default

git remote add $APP_NAME dokku@$REMOTE_IP:$BRANCH_NAME
git push $APP_NAME $BRANCH_NAME:master
ssh root@$REMOTE_IP dokku proxy:ports-set $APP_NAME http:80:3000
```