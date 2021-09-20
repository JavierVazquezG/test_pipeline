FROM python:3.6-slim
RUN apt-get update && apt-get install -y curl git
RUN pip install requests && pip install gitpython
ADD TFSec_part1 ~/tmp/
CMD ["~/tmp/TFSec_part1.py"]
ENTRYPOINT [ "python3" ]