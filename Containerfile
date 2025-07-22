FROM python:3.11-slim

USER 0

# Set the working directory to /app
WORKDIR /app

# Install CURL and CA certs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create the nb-mcp-server directory
RUN mkdir -p nb-mcp-server

# Install dependencies (installing uv and mcpo separately first, then requirements)
RUN pip install mcpo uv

# Copy the application code to the nb-mcp-server directory
COPY nb-mcp-server/ nb-mcp-server/

# Move into the project directory to install dependencies
WORKDIR /app/nb-mcp-server
RUN uv add -r requirements.txt

# Return to app base
WORKDIR /app

# Expose the app port
EXPOSE 8000

# Use shell form so all OpenShift-injected env vars are expanded
CMD UV_NATIVE_TLS=true \
  uvx mcpo --host 0.0.0.0 --port 8000 \
  -- uv --directory /app/nb-mcp-server run server.py
