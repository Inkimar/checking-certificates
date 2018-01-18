# checking-certificates

## The reason for this project
To check the validity of your SSL-cert(s).
This project spins up a number of webservers each with a domain&subdomains.
The proxy-server handles the certs (put your certs in the 'certs'-directory)

## pre-requirements
if running on Linux.
the dnsmasq could require the following changes:

edit the file  "/etc/resolvconf/resolvconf.d/head" 
add the row "nameserver 172.17.0.1"
So that your host will first check the "dnsmasq"


