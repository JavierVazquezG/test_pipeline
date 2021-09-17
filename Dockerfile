FROM       python:3.7-slim

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

# Install pipenv and compilation dependencies
RUN pip install pipenv
RUN apt-get update && apt-get install -y

# Install python dependencies in /.venv
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy

COPY       . /app
WORKDIR    /app
ENTRYPOINT ["pipenv", "run"]
CMD        ["python"]