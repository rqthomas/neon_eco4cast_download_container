FROM rocker/tidyverse

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	cron \
	R -e "install.packages(c('neonstore'))"
	
COPY download_neon_data.R download_neon_data.R

COPY hello-cron /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron && \
    crontab /etc/cron.d/hello-cron

RUN R -e "devtools::install_github('eco4cast/NEONeco4cast')"

# Run the command on container startup
#CMD ["cron", "-f"]


