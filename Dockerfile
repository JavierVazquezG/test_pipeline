FROM python:slim
RUN pip install requests
COPY TFSec_part1.py /tmp/
CMD ["python", "/tmp/TFSec_part1.py"]