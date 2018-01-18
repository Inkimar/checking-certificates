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

### curl: postivie test:  If the SSL is valid for the domain(s) 
$ curl https://naturforskaren.se

The reply from the curl-requests should be a valid html-page ("Welcome to nginx!")

if needed the CA-cert must be used with curl (DigitCertCA.crt-file provided by Digicert, included in the zip-file)<br>
$ curl --cacert DigiCertCA.crt https://naturforskaren.se

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
ref [1] http://manpages.ubuntu.com/manpages/zesty/man8/resolvconf.8.html

