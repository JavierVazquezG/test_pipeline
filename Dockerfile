FROM python:slim
RUN apt-get -y install git
RUN pip install requests
COPY TFSec_part1.py /tmp/
CMD ["python", "/tmp/TFSec_part1.py"]