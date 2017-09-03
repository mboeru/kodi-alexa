FROM python:2.7-slim
MAINTAINER Marius Boeru <mboeru@gmail.com>

ENV INSTALL_PATH /kodi-alexa
ENV GUNICORN_LOGLEVEL info
ENV GUNICORN_WORKERS 2
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH


#get latest
#RUN git clone https://github.com/m0ngr31/kodi-alexa.git .
COPY . $INSTALL_PATH

#install requirements
RUN apt-get update && apt-get -y install libffi-dev libssl-dev gcc && \
    pip install -r requirements.txt  && \
    apt-get -y remove gcc && \
    apt-get -y autoremove

CMD gunicorn --log-level $GUNICORN_LOGLEVEL -b 0.0.0.0:8000 alexa:app
