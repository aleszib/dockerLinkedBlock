FROM rocker/tidyverse

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  git \
  redis-tools \
  libglpk-dev \
  build-essential \
  libgdal-dev \
  libproj-dev \
  libudunits2-dev \
  libopenmpi-dev \
  python3 \
  python3-scipy \
  python3-numpy \
  python3-matplotlib \
  python3-pip \
  software-properties-common\
## clean up
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
	
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  dirmngr \
  gpg-agent \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 612DEFB798507F25 \
  && add-apt-repository "deb [ arch=amd64 ] https://downloads.skewed.de/apt $(lsb_release -cs) main" \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  python3-graph-tool \
  && apt-get clean 

##COPY installMy.r .
 
RUN install.r --error \
  --deps TRUE \
  --skipinstalled \
  devtools \
  blockmodels \
  RCurl \
  dynsbm \
  reticulate \
  devtools \
  ggplot2 \
  RcppArmadillo \
  doParallel \
  foreach \
  doRNG

RUN R -e 'install.packages("blockmodeling", repos="http://R-Forge.R-project.org")' \
	&& R -e 'install.packages("StochBlock", repos="http://R-Forge.R-project.org")' \ 
	&& R -e 'install.packages("kmBlockTest", repos="http://R-Forge.R-project.org")' \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN R -e 'remotes::install_github(c("Chabert-Liddell/MLVSBM","karthik/rdrop2"))' \
    && install.r --error \
	--deps TRUE \
	--skipinstalled \
        doRedis \
	GREMLINS \
	Microsoft365R \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
	

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  python3-cairo \
  libxt6 \
  libgtk-3-0 \
  libgtk-3-dev

ENV RETICULATE_PYTHON="/usr/bin/python3"
