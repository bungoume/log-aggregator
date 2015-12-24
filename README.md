# log-aggregator (Fluentd in docker container)

Input

* access log
  * access.nginx
  * access.uwsgi
* syslog
  * alert.allmessages
* action log
  * action.appname

## build

```
sudo docker build -t bungoume/log-aggregator .
```

## boot

set ENV `ES_HOST=<elasticsearch_host>`
set ENV `S3_REGION=<ap-northeast-1>`
set ENV `S3_BUCKET_NAME=<bucket_name>`
set ENV `AWS_ACCESS_KEY_ID=<access_key>`
set ENV `AWS_SECRET_ACCESS_KEY=<secret_key>`

```
sudo docker run -e "TO_HOST=logserver.example.com" -v /var/run/docker.sock:/tmp/docker.sock -d bungoume/log-aggregator
```
