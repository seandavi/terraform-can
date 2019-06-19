#!/bin/bash

set -xe

function apt-get1() { while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo 'apt-get is waiting for the lock release ...'; sleep 10; done; sleep 10; /usr/bin/apt-get "$@";}
#function apt-get() { while [[ fuser -s /var/lib/dpkg/lock ]] || [[ /var/lib/dpkg/lock-frontend ]]; do echo 'apt-get is waiting for the lock release ...'; sleep 1; done; sleep 5; /usr/bin/apt-get "$@"; }

echo 'www-port=8080' | sudo tee /etc/rstudio/rserver.conf
sudo rstudio-server restart || true
sudo bash -c 'while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/apt/lists/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo "apt-get is waiting for the lock release ..."; sleep 5; done; /usr/bin/apt-get update'
sudo bash -c 'while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/apt/lists/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo "apt-get is waiting for the lock release ..."; sleep 5; done; /usr/bin/apt-get install -y apt-transport-https ca-certificates curl software-properties-common cwltool hisat2'
Rscript -e "options(Ncpus=32); BiocManager::install(c('rmarkdown', 'webshot'))"
Rscript -e "options(Ncpus=32); BiocManager::install('hubentu/BioC19CWL')"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo bash -c 'while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/apt/lists/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo "apt-get is waiting for the lock release ..."; sleep 5; done; add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"'
sudo bash -c 'while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/apt/lists/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo "apt-get is waiting for the lock release ..."; sleep 5; done; /usr/bin/apt-get update'
sudo bash -c 'while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/apt/lists/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo "apt-get is waiting for the lock release ..."; sleep 5; done; /usr/bin/apt-get install -y docker-ce'
sudo bash -c 'while fuser -s /var/lib/dpkg/lock || fuser -s /var/lib/apt/lists/lock || fuser -s /var/lib/dpkg/lock-frontend ; do echo "apt-get is waiting for the lock release ..."; sleep 5; done; /usr/bin/apt-get update'
sudo usermod -aG docker ubuntu
#sudo usermod -aG rstudio docker
#sudo usermod -aG bioc docker
sudo mkdir /bioc-local
sudo chown ubuntu /bioc-local
    cd /bioc-local
    wget https://s3.amazonaws.com/biocbuild.cancerdatasci.org/bioc2019-usr-local.tar.gz
    tar -xzf bioc2019-usr-local.tar.gz
    sudo docker run --name bioc_2019 -d -v /bioc-local:/usr/local/lib/R/site-library \
        --restart=always \
        -p 80:8787 -e PASSWORD=bioc seandavi/bioc_2019
cat <<EOF | sudo tee /etc/systemd/system/docker-bioc-2019.service
[Unit]
Description=Bioconductor Docker
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a bioc_2019
ExecStop=/usr/bin/docker stop -t 2 bioc_2019

[Install]
WantedBy=default.target
EOF
sudo systemctl enable docker-bioc-2019
    
