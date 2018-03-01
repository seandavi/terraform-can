#!/bin/bash
# this shell script will run at startup
echo "hello" > /tmp/abc.out
# working directory for the script is '/'
echo "hello2" > abc.out2

# shiny server
sudo su - \
-c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages('rmarkdown', repos='https://cran.rstudio.com/')\""
apt-get install gdebi-core
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
dpkg -i shiny-server-1.5.6.875-amd64.deb
apt-get install git
wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O /tmp/miniconda.sh
bash /tmp/miniconda.sh -b -p /home/ubuntu/miniconda
echo 'export PATH="/home/ubuntu/miniconda/bin:$PATH"' >> /home/ubuntu/.bashrc
chown -R ubuntu:ubuntu /home/ubuntu/miniconda
