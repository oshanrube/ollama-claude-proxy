FROM python:3.9-slim

WORKDIR /app

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY proxy.py .
EXPOSE 11434

# Environment variables (can be overridden at runtime)
# For Anthropic API mode (default):
# ENV ANTHROPIC_API_KEY=""
# ENV FLASK_PORT=11434

# For Vertex AI mode:
# ENV USE_VERTEX_AI=1
# ENV VERTEX_PROJECT_ID=""
# ENV VERTEX_REGION="us-east5"
# ENV FLASK_PORT=11434

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:11434/ || exit 1

CMD ["python", "proxy.py"]
