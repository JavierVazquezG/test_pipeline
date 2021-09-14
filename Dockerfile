FROM       python
RUN        pip install pipenv
COPY       . /app
WORKDIR    /app
RUN        pip3 install --upgrade pip && pip3 install pipenv && pip install GitPython
RUN        pipenv shell
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]