FROM       python
RUN        pip install pipenv
COPY       . /app
WORKDIR    /app
RUN        pip3 install --upgrade pip && pip3 install pipenv && python3 -m pip install requests
ENV        SHELL=/bin/bash
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]