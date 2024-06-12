FROM python:3.10
ENV PYTHONUNBUFFERED 1

# Requirements have to be pulled and installed here, otherwise caching won't work
COPY ./requirements /requirements

RUN pip install --upgrade pip \
	&& pip install numpy \
	&& pip install -r /requirements/production.txt \
    && groupadd -r django \
    && useradd -r -g django django

COPY . /app
RUN chown -R django /app

COPY ./gunicorn.sh /gunicorn.sh
COPY ./entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh \
    && sed -i 's/\r//' /gunicorn.sh \
    && chmod +x /entrypoint.sh \
    && chown django /entrypoint.sh \
    && chmod +x /gunicorn.sh \
    && chown django /gunicorn.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
