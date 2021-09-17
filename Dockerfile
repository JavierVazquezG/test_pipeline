FROM python:slim
RUN pip install requests && python3 -m pip install GitPython 
COPY TFSec_part1.py /tmp/
CMD ["python", "/tmp/TFSec_part1.py"]