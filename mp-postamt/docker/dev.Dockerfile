FROM python:3-alpine

WORKDIR /app

COPY ./requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY ./src /app/src

ARG SMTP_RELAY_HOST
ARG SMTP_RELAY_PORT
ARG SMTP_RELAY_USERNAME
ARG SMTP_RELAY_PASSWORD
ARG PYTHONUNBUFFERED="true"

# Set environment variables using build arguments
ENV SMTP_RELAY_HOST=$SMTP_RELAY_HOST
ENV SMTP_RELAY_PORT=$SMTP_RELAY_PORT
ENV SMTP_RELAY_USERNAME=$SMTP_RELAY_USERNAME
ENV SMTP_RELAY_PASSWORD=$SMTP_RELAY_PASSWORD
ENV PYTHONUNBUFFERED="${PYTHONUNBUFFERED}"

EXPOSE 2222

ENTRYPOINT ["python3"]

CMD ["src/app.py"]