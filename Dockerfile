# Use a stable UBI image with Python 3
FROM registry.access.redhat.com/ubi8/python-39

# Set working directory
WORKDIR /app

# Copy only requirements first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port
EXPOSE 5000

# Environment variables (can be overridden in ECS)
ENV FLASK_ENV=production
ENV APP_CONFIG_FILE=config.py

# Use gunicorn for production WSGI serving
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--time", "120" "app.app:app"]
