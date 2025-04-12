FROM ubuntu:latest
LABEL "Author"="Vishy"
LABEL "Project"="python"

# Install system dependencies and create a virtual environment
RUN apt update && apt install -y python3 python3-pip python3-venv

# Set up a virtual environment
RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install --upgrade pip
RUN /opt/venv/bin/pip install flask

EXPOSE 8080

WORKDIR /app
COPY python/ /app/

# Ensure the app uses the virtual environment
CMD ["/opt/venv/bin/python", "ops.py"]



