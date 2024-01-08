# Node Exporter RPM Build Script

Este script Bash simplifica o processo de compilação e empacotamento do Node Exporter em um pacote RPM, facilitando a instalação e configuração em sistemas baseados em Red Hat.

## Pré-requisitos

Antes de utilizar este script, certifique-se de que os seguintes requisitos estejam instalados no seu sistema:

- [Git](https://git-scm.com/)
- [Go](https://go.dev/dl/)
- [NFPM](https://nfpm.goreleaser.com/)

## Como Usar

1. **Clone o Repositório:**

```bash
git clone https://github.com/marcelobaptista/scripts.git
cd scripts/node-exporter-rpm
```

2. **Edite o arquivo** `build-rpm.sh`` **preenchendo os valores desejados nas variáveis**

3. **Execute o Script:**

```bash
./build-node_exporter-rpm.sh
```

Isso realizará as seguintes etapas:

    - Baixa o código-fonte do Node Exporter do repositório oficial.
    - Remove coletores não habilitados por padrão. (opcional)
    - Remove coletores habilitados por padrão. (opcional)
    - Compila o Node Exporter.
    - Cria um pacote RPM utilizando a ferramenta NFPM na pasta RPMs.
    - Gera um serviço systemd para iniciar o Node Exporter como um serviço do sistema.

## Após gerar o RPM

Copie o arquivo .rpm para sua máquina e a partir da localização do pacote, instale o Pacote RPM:

```bash
# com o comando rpm
sudo rpm -ivh node_exporter-1.7.0.x86_64.rpm

# com o gerenciador yum
sudo yum install node_exporter-1.7.0.x86_64.rpm
```
