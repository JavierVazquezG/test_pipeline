FROM       python
RUN        pip install pipenv
COPY       . /app
WORKDIR    /app
RUN        pipenv install --deploy --dev
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]