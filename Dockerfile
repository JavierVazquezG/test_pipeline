FROM       python:3
ADD        TFSec_part1.py /
WORKDIR    /
RUN        pipenv install --deploy --dev
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python", "./TFSec_part1.py"]