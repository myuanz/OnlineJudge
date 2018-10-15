FROM python:3.6-alpine3.6

ENV OJ_ENV production

ADD . /app
WORKDIR /app

HEALTHCHECK --interval=5s --retries=3 CMD python2 /app/deploy/health_check.py
# CMD "wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py && python oh-my-tuna.py" 

# RUN echo -e "http://mirrors.aliyun.com/alpine/v3.6/main\nhttp://mirrors.aliyun.com/alpine/v3.6/community" > /etc/apk/repositories

RUN apk add --update --no-cache build-base nginx openssl curl unzip supervisor jpeg-dev zlib-dev postgresql-dev freetype-dev && \
    pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r /app/deploy/requirements.txt && \
    apk del build-base --purge

#RUN curl -L  $(curl -s  https://api.github.com/repos/QingdaoU/OnlineJudgeFE/releases/latest #| grep /dist.zip | cut -d '"' -f 4) -o dist.zip && \
#    unzip dist.zip && \
#    rm dist.zip
ADD dist.zip .
RUN unzip dist.zip
    
    
ENTRYPOINT /app/deploy/entrypoint.sh
