FROM python:OJBase

ENV OJ_ENV production

ADD . /app
WORKDIR /app

HEALTHCHECK --interval=5s --retries=3 CMD python2 /app/deploy/health_check.py

ADD dist.zip .
RUN unzip dist.zip
    
    
ENTRYPOINT /app/deploy/entrypoint.sh
