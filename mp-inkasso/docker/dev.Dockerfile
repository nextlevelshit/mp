FROM rstropek/pandoc-latex:latest

ARG PYTHONUNBUFFERED="true"
ENV PYTHONUNBUFFERED="${PYTHONUNBUFFERED}"

RUN apk add --no-cache --update \
    make \
    python3 py-pip \
    fontconfig ttf-freefont font-noto

WORKDIR /app

RUN tlmgr update --self
RUN tlmgr install ragged2e xltxtra realscripts wallpaper eso-pic \
    titlesec arydshln spreadtab enumitem xstring
#RUN tlmgr install hhline xcolor

COPY ./requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt

COPY ./data /app/data
COPY ./src /app/src
COPY ./makefile /app/makefile

EXPOSE 1111

ENTRYPOINT ["/usr/bin/python3"]

CMD ["src/app.py"]
