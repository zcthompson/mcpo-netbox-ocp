# NetBox MCP Integration for OpenShift

This repository builds an **OpenAPI-compatible MCP Tools Server** and implements a read-only **NetBox MCP Server**, allowing interaction with NetBox data via LLMs that support [Model Context Protocol (MCP)](https://modelcontextprotocol.io/). The container is designed for deployment into OpenShift environments to support automated infrastructure management and LLM-driven tooling.

## 📆 Repository Contents

- `Containerfile` – Image definition used to package the NetBox MCP server.
- `nb-mcp-server/` – Application logic to enable NetBox client code from NB Lab + MCP integration.
- `nb-mcp-server/requirements.txt` – Python dependencies required for the container build.

---

## 🔧 Prerequisites

- [Podman](https://podman.io/) installed on your system.
- Access to a [Quay.io](https://quay.io) repository (create an account and repo if not done).
- Clone this repository:

### Clone the repository and navigate to the folder

```bash
git clone https://github.com/zcthompson/mcpo-netbox-ocp.git
cd mcpo-netbox-ocp
```

### Run the podman build command and tag the image, see example

```bash
podman build -t nb_mcpo_server:latest --platform="linux/amd64" .
```

After this completes you should see writing manifest, next push the image to quay or your available image repository

```
podman push <image_manifest_id_from_creation> quay.io/your_repository/image_name:latest
```

## 📚 References

### 🔗 OpenWeb UI Integration Docs
- [OpenWeb UI – OpenAPI Servers](https://docs.openwebui.com/openapi-servers/open-webui)
- [OpenWeb UI – MCP Integration](https://docs.openwebui.com/openapi-servers/mcp)

### 🧰 OpenWeb UI Tools Server GitHub
- [open-webui/openapi-servers](https://github.com/open-webui/openapi-servers)

### 🧠 NetBox Labs MCP Server GitHub
- [netboxlabs/netbox-mcp-server](https://github.com/netboxlabs/netbox-mcp-server)
