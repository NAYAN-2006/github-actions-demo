FROM python:3.12-slim

WORKDIR /app

COPY app.py .
COPY test_app.py .

RUN pip install --no-cache-dir pytest

EXPOSE 5000

CMD ["python", "app.py"]
