#!/bin/bash
# this shell script will run at startup
echo "hello" > /tmp/abc.out
# working directory for the script is '/'
echo "hello2" > abc.out2

# R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install -y r-base
sudo apt install -y libxml2-dev
sudo apt install -y libssl-dev
sudo apt install -y libcurl4-openssl-dev

# shiny server
sudo su - \
-c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
sudo su - \
-c "R -e \"install.packages(c('rmarkdown', 'shiny', 'R6', 'BiocManager'), repos='https://cran.rstudio.com/')\""
sudo apt-get install -y gdebi-core
sudo wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb
sudo gdebi -n shiny-server-1.5.7.907-amd64.deb
sudo apt-get install -y git
sudo wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O /tmp/miniconda.sh
sudo bash /tmp/miniconda.sh -b -p /home/ubuntu/miniconda
echo 'export PATH="/home/ubuntu/miniconda/bin:$PATH"' >> /home/ubuntu/.bashrc
sudo chown -R ubuntu:ubuntu /home/ubuntu/miniconda
sudo git clone https://github.com/seandavi/terraform-can
sudo cp -r terraform-can/modules/bioc-devel-ami/scripts/register /srv/shiny-server/
sudo chown -R shiny:shiny /srv/shiny-server/register
sudo R_LIBS_USER=/usr/local/lib/R/library Rscript terraform-can/modules/bioc-devel-ami/scripts/bootstrap_users.R
sudo wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.1335-amd64.deb
sudo gdebi -n rstudio-server-1.2.1335-amd64.deb
sudo bash -c "echo 'www-port=80' >> /etc/rstudio/rserver.conf"
sudo service rstudio-server restart
