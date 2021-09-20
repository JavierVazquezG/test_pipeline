FROM python:3.6-slim
RUN apt-get update && apt-get install -y curl git
RUN pip install requests
COPY TFSec_part1.py /tmp/
CMD ["python", "/tmp/TFSec_part1.py"]