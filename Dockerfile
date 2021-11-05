FROM linuxbrew/brew
WORKDIR /usr/src/app

RUN brew install tfsec && brew install python3 && brew install git
RUN pip3 install requests && pip3 install gitpython
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

COPY . .
CMD ["TFSec_part1.py"]
ENTRYPOINT ["python3"]