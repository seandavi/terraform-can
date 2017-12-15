#!/bin/bash
cd /home/ubuntu
su -c 'wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh' - ubuntu
su -c 'bash ~/miniconda.sh -b -p $HOME/.miniconda3' - ubuntu
su -c 'echo "export PATH="$HOME/.miniconda3/bin:$PATH"" >> ~/.bashrc' - ubuntu
pip install awscli

