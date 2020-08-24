FROM python:3.7.2

COPY requirements.txt /
RUN pip install -r requirements.txt

COPY app.py /
RUN python app.py

EXPOSE 5000
