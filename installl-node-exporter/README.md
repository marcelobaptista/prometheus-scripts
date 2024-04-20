# Node Exporter install script

Este script Bash que simplifica a instalação do Node Exporter em distribuições Linux.

## Arquiteuras suportadas

- x86_32
- x86_64
- armv5
- armv6
- armv7
- arm64

## Pré-requisitos

Certifique-se de ter instalado o seguinte:

- [curl](https://curl.se/download.html): para baixar o Node Exporter e suas dependências.
- Acesso de administrador (`sudo` ou `root`) para executar comandos.

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

2. **Forneça permissão de execução:**

```bash
sudo chmod +x install-node_exporter.sh
```

3. **Execute o script:**

```bash
sudo ./install-node_exporter.sh
```

4. **Informe a porta que deseja utilizar para o Node Exporter, caso não informe será utilizada a porta padrão 9100.**

```bash
$ Porta a ser usada pelo Node Exporter (padrão: 9100): 9300
```

5. **Após a instalação, verifique se o serviço do Node Exporter está em execução:**

```bash
systemctl status node_exporter
```