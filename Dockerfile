FROM ubuntu:latest
LABEL "Author"="Vishy"
LABEL "Project"="python"

# Install Python and pip
RUN apt update && apt install -y python3 python3-pip
EXPOSE 80

# Set working directory
WORKDIR /app

# Copy source code from host into container
COPY python-code/ /app/
CMD ["python3", "ops.py"]


