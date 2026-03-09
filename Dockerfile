# Start from an official Python base image
# Using slim version to keep the image size small
FROM python:3.11-slim

# Set the working directory inside the container
# All future commands will run from /app
WORKDIR /app

# Copy requirements file FIRST
# This is a Docker best practice — it uses layer caching
# If requirements don't change, Docker skips reinstalling packages
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

# Tell Docker your app runs on port 5000
EXPOSE 5000

# Create a non-root user for security
RUN useradd -m appuser
USER appuser

# The command to start your application
# We use gunicorn (a production-grade server) instead of Flask's dev server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
