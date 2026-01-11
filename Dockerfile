# Use a small, secure base image
FROM python:3.11.8-slim

# Set working directory
WORKDIR /app

# Install system dependencies (minimal)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency file first (layer caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Create non-root user (security best practice)
RUN useradd -m appuser
USER appuser

# Expose application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]

