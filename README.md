# devops

DevOps related Tools/Scripts


## Initialize a CentOS Host Environment
```
$ curl https://gitlab.com/nchain-public/devops/raw/master/init-centos-env.sh | sudo sh -s $hostname
```

## Install GitLab CI Runner on a CentOS Host
```
$ curl https://gitlab.com/nchain-public/devops/raw/master/install-gitlab-runner.sh | sudo sh
```

## Update Docker Mirror Registry using Chinese vendor DockerDAO
```
$ curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
or
$ curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://reg.ming.cn
```

## How to install docker on CentOS
```
https://docs.genesys.com/Documentation/System/latest/DDG/InstallationofDockerEngineCommunityEditiononCentOS7
```

## Install `docker-compose`
```
sudo curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o/usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

```

## Install Oh-My-Zsh
### install git
```$ sudo yum install -y git ```

### install ZSH
```$ sudo yum install -y zsh ```

### install omz
```$ wget https://gitlab.com/nchain-public/devops/raw/master/install-oh-my-zsh.sh -O - | zsh```

# Update domain certificate va Kong API

```zsh
#!/usr/bin/zsh

cert_dir=$1
snis=$2

curl -i -X POST http://localhost:8001/certificates \
    -F "cert=@${cert_dir}.pem" \
    -F "key=@${cert_dir}.key" \
    -F "snis=${snis}"

```

# Increase Virtual RAM for CentOS

``` bash
sudo dd if=/dev/zero of=/mnt/swapfile bs=1M count=4096
sudo mkswap /mnt/swapfile
sudo chown root. /mnt/swapfile
sudo chmod 0600 /mnt/swapfile
sudo swapon /mnt/swapfile
sudo sh -c 'echo "/mnt/swapfile none swap sw 00" >> /etc/fstab'
```

# Enable scroll in Tmux
```
vim ~/.tmux.conf
set -g mode-mouse on      ###Insert this setting with vim, then source the file.
tmux source-file ~/.tmux.conf
```

## 如果在容器里面无法ping通docker0地址，一般是防火墙问题，需要运行以下命令
```
$ sudo iptables -I INPUT 1 -i docker0 -j ACCEPT
$ sudo service iptables save
```

```
sudo iptables -I INPUT -p tcp -m tcp --dport 8888 -j ACCEPT
sudo iptables -I INPUT -p tcp -m tcp --dport 19888 -j ACCEPT
sudo iptables -I INPUT -p tcp -m tcp --dport 19777 -j ACCEPT

sudo firewall-cmd --add-port=8888/tcp

## enable ICMP
sudo iptables -I INPUT 1 -p icmp -j ACCEPT

sudo service iptables save
```


## Install docker-ce and uninstall podman
```
yum install docker-ce.x86_64 --allowerasing
```

## Launch a v2ray docker
```
OCON=/opt/v2ray
ICON=/etc/v2ray

docker run -d --name v2ray -v $OCON:/etc/v2ray -p 7777:25217 v2ray/official  v2ray -config=$ICON/config.json
```

## GitLab docker Installation

* https://github.com/mgcrea/docker-compose-gitlab-ce/blob/master/docker-compose.yml

## How to clear docker logs
```
sudo su && \
 for container_id in $(docker ps -aq) \
 do \
   log_file=$(docker inspect --format='{{.LogPath}}' "$container_id") \
   echo "" > $log_file \
 done
```

## Telegram proxy docker

* https://hub.docker.com/r/telegrammessenger/proxy/

## How to change block UUID
```
sudo tune2fs -U random /dev/vdb 
```
