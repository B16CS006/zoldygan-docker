FROM python:3.7

RUN pip install django
RUN pip install pycrypto

CMD cd /app && python manage.py runserver ludo:8001
