FROM ghcr.io/osgeo/gdal:ubuntu-small-3.6.3

WORKDIR /app

ARG EXECUTOR

ENV EXECUTOR=${EXECUTOR}
RUN apt-get update && \
    apt-get install -y python3.10 python3-pip wget && \
    pip3 install --upgrade pip

ENV PYTHONBUFFERED 1
RUN echo ${EXECUTOR}
COPY demo-test/requirements.txt .

ADD ./clay/python /app/clay/python
RUN pip3 install -r requirements.txt -r /app/clay/python/requirements/requirements-dev.txt
RUN pip3 install /app/clay/python

COPY demo-test/demo-test /app

ENTRYPOINT ["python3", "entry.py"]
