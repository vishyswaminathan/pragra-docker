# --- Build stage ---
    FROM python:3.12-slim as build
    LABEL "Author"="Vishy"
    LABEL "Project"="python"
    
# Update and upgrade base OS packages to reduce CVEs (vulnerabilities)
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*


    # Install system dependencies and create a virtual environment
    RUN python3 -m venv /opt/venv
    
    # Upgrade pip and install app dependencies inside the venv
    RUN /opt/venv/bin/pip install --upgrade pip
    RUN /opt/venv/bin/pip install flask
    
    # Copy application code
    WORKDIR /app
    COPY python/ /app/
    
    
    # --- Final stage (distroless) ---
    FROM gcr.io/distroless/python3-debian12
    
    # Copy the virtual environment and app from the build stage
    COPY --from=build /opt/venv /opt/venv
    COPY --from=build /app /app
    
    WORKDIR /app
    
    EXPOSE 8080
    
    # Run the application using the Python inside the virtual environment
    CMD ["/opt/venv/bin/python", "ops.py"]
    
