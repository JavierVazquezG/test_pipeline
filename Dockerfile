FROM       python
RUN        pip install pipenv
COPY       . /app
WORKDIR    /app
RUN        pip install GitPython && pipenv install --deploy --dev
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]