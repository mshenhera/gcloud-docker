FROM python:2.7

ENV SDK_VERSION 161.0.0
ENV SDK_FILENAME google-cloud-sdk-${SDK_VERSION}-linux-x86_64.tar.gz
ENV SDK_URL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${SDK_FILENAME}
ENV PATH ${PATH}:/opt/google-cloud-sdk/bin
ENV GAE_PYTHONPATH /opt/google_appengine
ENV PYTHONPATH ${PYTHONPATH}:${GAE_PYTHONPATH}

ADD fetch_gae_sdk.py /opt/scripts/fetch_gae_sdk.py
 
RUN pip install ansible-vault j2cli
RUN export CLOUDSDK_CORE_DISABLE_PROMPTS=1 && \
    cd /opt/ && \
    curl -O -J $SDK_URL && \
    tar -zxvf $SDK_FILENAME --directory /opt && \
    python scripts/fetch_gae_sdk.py $(dirname "${GAE_PYTHONPATH}")

