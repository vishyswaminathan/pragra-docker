FROM ubuntu:latest
LABEL "Author"="Vishy"
LABEL "Project"="python"

# Install Python, pip, and Flask
RUN apt update && apt install -y python3 python3-pip && pip3 install flask

EXPOSE 8080

WORKDIR /app
COPY python/ /app/
CMD ["python3", "ops.py"]



