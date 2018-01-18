# checking-certificates

## The reason for this project
To check the validity of your SSL-cert(s).
This project spins up a number of webservers each with a domain&subdomains.
The proxy-server handles the certs (put your certs in the 'certs'-directory)

## pre-requirements
if running on Linux.<br>
the dnsmasq could require the following changes:

"/etc/resolvconf/resolvconf.d/head" 
add the row "nameserver 172.17.0.1"<br>
run `$sudo resolvconf -u`

might be needed to restart the docker-daemon ( `sudo service docker restart` / `sudo systemctl status docker.service` ) 

So that your host will first check the "dnsmasq"
this means you do not have to add your domains to the /etc/hosts-file

## how to run
`make up`

## My Machine
1. OS :  'Linux Mint 17.3 Rosa'
2. docker version : 17.05.0-ce 
3. docker-compose version : 1.16.1, build 6d1ac21
4. Make : GNU Make 3.81

## References
ref [1] http://manpages.ubuntu.com/manpages/zesty/man8/resolvconf.8.html

