# python runtime image
FROM python:3.10-slim 

# setting a working directory in container
WORKDIR /app

# copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy entire project in container
COPY . .

# exposes port 5000
EXPOSE 5000

# runs the application
CMD ["python", "app.py"]