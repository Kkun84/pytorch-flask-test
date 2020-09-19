FROM python:3.8

# Timezone setting
RUN apt-get update && apt-get install -y --no-install-recommends tzdata

# Install
RUN apt-get update && apt-get install -y --no-install-recommends fish nano git sudo curl gosu

#  Python
COPY requirements.txt /
RUN pip install -r /requirements.txt

# OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends libsm6 libxrender1

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

ENV PYTHONPATH "/workspace/"
WORKDIR "/workspace/"

ARG UID
ARG GID
ARG USER
ARG PASSWORD
RUN useradd -m --uid=${UID} --groups=sudo ${USER}
RUN echo ${USER}:${PASSWORD} | chpasswd
RUN echo 'root:root' | chpasswd

USER ${USER}

CMD ["heroku", "local"]


# RUN mkdir /dataset


# RUN apt-get install -y gosu
# COPY entrypoint.sh /
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
