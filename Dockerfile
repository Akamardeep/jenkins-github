FROM ubuntu:22.04
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip install flask==3.0.*
COPY  test.py /
ENV FLASK_APP=test
EXPOSE 7000
CMD ["flask", "run", "--host", "0.0.0.0", "--port", "7000"]


