FROM rocker/tidyverse

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libxml2 \
  git \
  redis-tools \
  libxml2-dev \
  libglpk-dev \
  build-essential \
  libglpk40 \
  libgdal-dev\
## clean up
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
 
RUN install2.r --error \
  --deps TRUE \
  devtools \
  ggplot2 \
  blockmodels
  
RUN R -e 'install.packages("blockmodeling", repos="http://R-Forge.R-project.org")' \
	&& R -e 'install.packages("StochBlockTest", repos="http://R-Forge.R-project.org")' \ 
	&& R -e 'remotes::install_github("bwlewis/doRedis")' \ 
	&& R -e 'remotes::install_github("karthik/rdrop2")' \
	&& R -e 'remotes::install_github("Demiperimetre/GREMLINS")' \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

