Here’s your revised documentation with the adjustments to explain how to use `Containerfile.insecure` or `Containerfile.secure`, depending on whether the API endpoint should be secured:

---

# NetBox MCP Integration for OpenShift

This repository builds an **OpenAPI-compatible MCP Tools Server** and implements a read-only **NetBox MCP Server**, allowing interaction with NetBox data via LLMs that support [Model Context Protocol (MCP)](https://modelcontextprotocol.io/). The container is designed for deployment into OpenShift environments to support automated infrastructure management and LLM-driven tooling.

## 📆 Repository Contents

* `Containerfile.insecure` – Base image for NetBox MCP server without API authentication.
* `Containerfile.secure` – Base image for NetBox MCP server with API key authentication enabled.
* `nb-mcp-server/` – Application logic enabling NetBox client integration with MCP.
* `nb-mcp-server/requirements.txt` – Python dependencies required for the container build.

---

## 🔧 Prerequisites

* [Podman](https://podman.io/) installed on your system.
* Access to a [Quay.io](https://quay.io) repository (create an account and repo if not done).
* Clone this repository:

### Clone the repository and navigate to the folder

```bash
git clone https://github.com/zcthompson/mcpo-netbox-ocp.git
cd mcpo-netbox-ocp
```

---

## 🛠️ Select a Containerfile Variant

To build the container with or without API key security:

* For **insecure (unauthenticated)** access:

  ```bash
  cp Containerfile.insecure Containerfile
  ```

* For **secure (authenticated)** API key support:

  ```bash
  cp Containerfile.secure Containerfile
  ```

Then proceed with the container build.

---

## 🏗️ Build and Push the Image

### Build the container image

```bash
podman build -t nb_mcpo_server:latest --platform="linux/amd64" .
```

### Push the image to your container registry

```bash
podman push <image_manifest_id_from_creation> quay.io/your_repository/image_name:latest
```

---

## 🔗 OpenShift Deployment

Look in the `examples/` folder for a basic OpenShift Deployment configuration that deploys the MCP Tool Server for integration with OpenWebUI (coming soon).

---

## 🔐 Securing the API Endpoint (If Using `Containerfile.secure`)

If you've used `Containerfile.secure`, it includes:

```bash
--api-key "${API_TOKEN}" -- uv run --directory /app/nb-mcp-server run server.py
```

Ensure your deployment (e.g. OpenShift) sets the `API_TOKEN` environment variable, such as through a Kubernetes Secret or environment field in your `Deployment` spec.

---

## 🔧 Complete Integration with OpenWebUI

After the container is built and deployed, refer to the [OpenWebUI integration documentation](https://docs.openwebui.com/openapi-servers/mcp) to configure and securely connect your MCP server.

---

## 📚 References

### 🔗 OpenWeb UI Integration Docs

* [OpenWeb UI – OpenAPI Servers](https://docs.openwebui.com/openapi-servers/open-webui)
* [OpenWeb UI – MCP Integration](https://docs.openwebui.com/openapi-servers/mcp)

### 🧰 OpenWeb UI Tools Server GitHub

* [open-webui/openapi-servers](https://github.com/open-webui/openapi-servers)

### 🧠 NetBox Labs MCP Server GitHub

* [netboxlabs/netbox-mcp-server](https://github.com/netboxlabs/netbox-mcp-server)

---
