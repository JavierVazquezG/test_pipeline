FROM       python
RUN        pip install pipenv
COPY       . /app
WORKDIR    /app
RUN        pip3 install --upgrade pip
RUN        pip3 install pipenv
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]