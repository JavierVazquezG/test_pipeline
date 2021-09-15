FROM       python
RUN        pip install pipenv
COPY       . /app
WORKDIR    /app
RUN        pipenv install --deploy --dev --ignore-pipfile
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]