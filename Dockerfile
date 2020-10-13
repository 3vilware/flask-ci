#FROM python:3.7.2

FROM python:3.10.0a1-alpine
COPY requirements.txt /
RUN pip install -r requirements.txt

COPY app.py /

EXPOSE 5000

CMD ["python", "app.py"]
