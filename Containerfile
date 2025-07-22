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

# Create the netbox-mcp-server directory
RUN mkdir -p netbox-mcp-server

# Install dependencies (installing uv and mcpo separately first, then requirements)
RUN pip install mcpo uv

# Copy the application code to the netbox-mcp-server directory
COPY netbox-mcp-server/ netbox-mcp-server/

# Move into the project directory to install dependencies
WORKDIR /app/netbox-mcp-server
RUN uv add -r requirements.txt

# Return to app base
WORKDIR /app

# Expose the app port
EXPOSE 8000

# Use shell form so all OpenShift-injected env vars are expanded
CMD UV_NATIVE_TLS=true \
  uvx mcpo --host 0.0.0.0 --port 8000 \
  -- uv --directory /app/netbox-mcp-server run server.py
