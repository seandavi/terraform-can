from bioconductor/devel_core2

RUN apt-get update
RUN apt-get install -y awscli

RUN Rscript -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_github("seandavi/CollaborativeBookdown")'

RUN apt-get install -y libv8-dev

WORKDIR /home/bioc/

COPY builder2.R .
COPY abc.Rmd .
COPY build.sh .
RUN chmod +x build.sh

CMD ["./build.sh"]
