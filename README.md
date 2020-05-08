# checking-certificates

## The reason for this project
To check the validity of your SSL-cert(s).
This project spins up a number of webservers each with a domain&subdomains.
The proxy-server handles the certs (put your certs in the 'certs'-directory)

## pre-requirements
You need to have docker,docker-compose and make installed.

if running on Linux.<br>
The dnsmasq requires the following changes:

"/etc/resolvconf/resolvconf.d/head" 
add the row "nameserver 172.17.0.1"<br>
To make the changes work:  run `$sudo resolvconf -u`

might be needed to restart the docker-daemon ( `sudo service docker restart` / `sudo systemctl status docker.service` ) 

So that your host will first check the "dnsmasq"
this means you do not have to add your domains to the /etc/hosts-file

## how to run
`make up`
this example runs 3 webservers with the domains; naturforskaren.se,www.naturforskaren.se and beta.naturforskaren.se

## check if the cert(s) is valid

1. curl -L naturforskaren.se
2. curl https://naturforskaren.se

### curl: positive test:  If the SSL is valid for the domain(s) 
$ curl https://naturforskaren.se

The reply from the curl-requests should be a valid html-page ("Welcome to nginx!")

if needed the CA-cert must be used with curl (The DigitCertCA.crt-file was provided by Digicert, included in the zip-file)<br>
1. $ curl --cacert DigiCertCA.crt https://naturforskaren.se
2. $ curl --cacert DigiCertCA.crt https://beta.naturforskaren.se
3. $ curl --cacert DigiCertCA.crt https://www.naturforskaren.se

### curl: negative test: if the SSL is NOT valid for the domain(s) 
$ curl https://naturforskaren.se

curl: (7) Failed to connect to naturforskaren.se port 443: Connection refused

the reply will be a HTTP 443.

### firefox: If the SSL is valid for the domain(s)
Check the green padlock on the left of the URL.

## My Machine
1. OS :  'Linux Mint 17.3 Rosa'
2. docker version : 17.05.0-ce 
3. docker-compose version : 1.16.1, build 6d1ac21
4. make : GNU Make 3.81
5. curl : curl 7.35.0

## References
1. ref http://manpages.ubuntu.com/manpages/zesty/man8/resolvconf.8.html
2. ref  https://curl.haxx.se/docs/manpage.html


## 2020-05-07 : comparison

### local machine (ubuntu 19.10)

1. docker -v        
2. Docker version 19.03.8, build afacb8b7f0
3. docker-compose -v
4. docker-compose version 1.23.2, build 1110ad01


#### docker-compose-file

```
version: '3.7'

services:

  proxy:
    image: jwilder/nginx-proxy:0.4.0
    container_name: jwilder-proxy
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - ./certs:/etc/nginx/certs:ro
      #- ./nginx-proxy.conf:/etc/nginx/conf.d/nginx-proxy.conf:ro
```

with certs 
1. md5sum nrm.se.crt -> 6a829a894cc10ee7bf194381318b3b3a  nrm.se.crt
2. md5sum nrm.se.key -> 1342e55379bf0d9e253a77d02e2c9f01  nrm.se.key

ps -> @docker-compose -f docker-compose.2020.yml ps 

make ps-test                 
            Name                          Command               State                    Ports                  
----------------------------------------------------------------------------------------------------------------
checking-certificates_web3_1   nginx -g daemon off;             Up      80/tcp                                  
jwilder-proxy                  /app/docker-entrypoint.sh  ...   Up      0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp

***
Test from curl: `curl - L local.nrm.se` -> det ser rätt ut (301, 200) <p>

jwilder-proxy | nginx.1    | local.nrm.se 172.19.0.1 - - [08/May/2020:09:51:48 +0000] "GET / HTTP/1.1" 301 185 "-" "curl/7.65.3"
web3_1   | 172.19.0.3 - - [08/May/2020:09:51:48 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.65.3" "172.19.0.1"
jwilder-proxy | nginx.1    | local.nrm.se 172.19.0.1 - - [08/May/2020:09:51:48 +0000] "GET / HTTP/2.0" 200 770 "-" "curl/7.65.3"


Test från firefox -> det ser rätt ut (301,200) <p>
jwilder-proxy | nginx.1    | local.nrm.se 172.19.0.1 - - [08/May/2020:09:54:09 +0000] "GET / HTTP/1.1" 301 185 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:76.0) Gecko/20100101 Firefox/76.0"
web3_1   | 172.19.0.3 - - [08/May/2020:09:54:09 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:76.0) Gecko/20100101 Firefox/76.0" "172.19.0.1"
jwilder-proxy | nginx.1    | local.nrm.se 172.19.0.1 - - [08/May/2020:09:54:09 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:76.0) Gecko/20100101 Firefox/76.0"



### birdringing-machine (ubuntu 18.04.4 LTS)
 
1. docker -v
2. Docker version 19.03.6, build 369ce74a3c
3. docker-compose -v
4. docker-compose version 1.22.0, build f46880fe

#### docker-compose-file
docker-compose.prod.yml-file → kör både proxy och shiny:

```
version: '3.7'

services:
  proxy:
    image: jwilder/nginx-proxy:0.4.0
    container_name: jwilder-proxy
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - ./certs:/etc/nginx/certs:ro
      - ./nginx-proxy.conf:/etc/nginx/conf.d/nginx-proxy.conf:ro
```

with certs 

    1. md5sum nrm.se.crt -> 6a829a894cc10ee7bf194381318b3b3a  nrm.se.crt
    3. md5sum nrm.se.key -> 1342e55379bf0d9e253a77d02e2c9f01  nrm.se.key

### local-machine : daemon.json-file

**/etc/docker/daemon.json**

```    
{
    "bip": "172.17.0.1/24",
    "dns": ["192.168.1.1","172.17.0.1", "172.16.0.5", "172.16.0.6", "8.8.8.8"],
    "dns-search": ["."]
}
```