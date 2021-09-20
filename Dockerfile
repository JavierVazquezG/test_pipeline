FROM python:slim
RUN pip install requests && python3 -m pip install gitpython 
COPY TFSec_part1.py /tmp/
CMD ["python", "/tmp/TFSec_part1.py"]