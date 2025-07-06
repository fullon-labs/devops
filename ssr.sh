## Install SSR Server 


$wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
$chmod +x shadowsocksR.sh
$./shadowsocksR.sh 2>&1 | tee shadowsocksR.log


## Open port 443 for SSR Server on CentOS 6.5
$sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
$sudo service iptables save

## Restart SSR Server

$sudo /etc/init.d/shadowsocks restar

## shadowsocks config

$cat /etc/shadowsocks.json
{
    "server":"0.0.0.0",
    "server_ipv6":"[::]",
    "server_port":443,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"XXXXX",
    "timeout":120,
    "method":"aes-256-cfb",
    "protocol":"auth_aes128_sha1",
    "protocol_param":"",
    "obfs":"tls1.2_ticket_auth",
    "obfs_param":"",
    "redirect":"",
    "dns_ipv6":false,
    "fast_open":false,
    "workers":1
}

## For more, pls refer to https://www.zfl9.com/ssr.html