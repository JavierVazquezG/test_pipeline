FROM       python:3
ADD        TFSec_part1.py /
WORKDIR    /
ENV        PYTHONPATH "${PYTHONPATH}:/"
ENV        SHELL=/bin/bash
CMD        ["python", "TFSec_part1.py"]