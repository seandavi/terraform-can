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
sudo apt-get install gdebi-core
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
sudo dpkg -i shiny-server-1.5.6.875-amd64.deb

