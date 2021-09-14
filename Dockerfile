FROM       python:3
RUN        pip install pipenv
COPY       . /app
WORKDIR    /
RUN        pip install GitPython && pipenv install --deploy --dev
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python3 TFSec_part1.py"]