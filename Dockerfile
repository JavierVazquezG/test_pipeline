FROM linuxbrew/brew
WORKDIR /usr/src/app

RUN brew install tfsec && brew install python3 && brew install git
RUN pip3 install requests && pip3 install gitpython

COPY . .
CMD ["test.py"]
ENTRYPOINT ["python3"]