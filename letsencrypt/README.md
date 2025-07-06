# Steps of how to use letsencrypt to generate/renew your domain certificate

## 1. make sure the domain DNS setting point to the IP where you run the following steps

## 2. conduct the following pre-steps for the first time only

1. create nginx dir `mkdir -p ~/nginx`
1. create `docker-compose.yml`
1. create conf.d dir `mkdir -p ~/nginx/conf.d`
1. add web.conf_ & webs.conf_

## 3. renew the certificate for the domain (run below only for each time to renew)

1. enable web.conf by removing "_"
1. run `docker-compose up -d` to retrieve certificate (remember to update domain name within the files)


## 4.1 host the website there via `htts` if needed

1. disable web.conf and enable webs.conf
1. run `docker-compose up -d` again to finish everything
1. test https access to the domain from outside the server 

## 4.2 otherwise change DNS cname setting for the domain to reach the actual site