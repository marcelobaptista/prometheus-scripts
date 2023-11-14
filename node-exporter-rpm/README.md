# Node Exporter RPM Build Script

Este script Bash simplifica o processo de compilação e empacotamento do Node Exporter em um pacote RPM, facilitando a instalação e configuração em sistemas baseados em Red Hat.

## Pré-requisitos

Antes de utilizar este script, certifique-se de que os seguintes requisitos estejam instalados no seu sistema:

- [Git](https://git-scm.com/)
- [NFPM](https://nfpm.goreleaser.com/)

## Como Usar

- Clone o Repositório:

```bash
git clone https://github.com/seu-usuario/.git
cd repositorio
```

- Edite o arquivo build-rpm.sh preenchendo os valores desejados nas variáveis
- Execute o Script:

```bash
./build-rpm.sh
```

Isso realizará as seguintes etapas:

    - Baixa o código-fonte do Node Exporter do repositório oficial.
    - Remove coletores não habilitados por padrão. (opcional)
    - Remove coletores habilitados por padrão. (opcional)
    - Compila o Node Exporter.
    - Cria um pacote RPM utilizando a ferramenta NFPM na pasta RPMs.
    - Gera um serviço systemd para iniciar o Node Exporter como um serviço do sistema.

- Copie o arquivo .rpm para sua máquina
- Instale o Pacote RPM (exemplo):

```bash
sudo rpm -ivh node_exporter-1.7.0.x86_64.rpm
```
