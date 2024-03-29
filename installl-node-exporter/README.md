# Node Exporter install script

Este script Bash que simplifica a instalação do Node Exporter em distribuições Linux.

## Pré-requisitos

Certifique-se de ter instalado o seguinte:

- [curl](https://curl.se/download.html): para baixar o Node Exporter e suas dependências.
- Acesso de administrador (`sudo` ou root) para executar comandos.

## Como usar

### Instalação automática

```bash
curl -s https://raw.githubusercontent.com/marcelobaptista/prometheus-scripts/main/installl-node-exporter/install-node_exporter.sh | sudo bash
```
### Instalação manual

1. **Baixe o arquivo** `install_node_exporter.sh`:

```bash
wget https://raw.githubusercontent.com/marcelobaptista/prometheus-scripts/main/installl-node-exporter/install-node_exporter.sh
```

2. **Execute o script:**

```bash
sudo bash install_node_exporter.sh
```

Certifique-se de fornecer permissões de execução:

```bash
sudo chmod +x install_node_exporter.sh
```

3. **Verifique o serviço:**

Após a instalação, verifique se o serviço do Node Exporter está em execução:

```bash
systemctl status node_exporter
```