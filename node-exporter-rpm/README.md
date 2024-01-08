# Node Exporter install script

Este script Bash que simplifica a instalação do Node Exporter em distribuições Linux.

## Pré-requisitos

Certifique-se de ter instalado o seguinte:

- [curl](https://curl.se/download.html): para baixar o Node Exporter e suas dependências.
- Acesso de administrador (`sudo` ou root) para executar comandos.

## Como usar

1. **Faça o download do script:** Clone este repositório ou baixe o script `install_node_exporter.sh`.

2. **Execute o script:**

    ```bash
    sudo bash install_node_exporter.sh
    ```

    Certifique-se de fornecer permissões de execução se necessário:

    ```bash
    sudo chmod +x install_node_exporter.sh
    ```

3. **Verifique o serviço:**

    Após a instalação, verifique se o serviço do Node Exporter está em execução:

    ```bash
    systemctl status node_exporter
    ```



# Node Exporter RPM Build Script

Este script Bash simplifica o processo de compilação e empacotamento do Node Exporter em um pacote RPM, facilitando a instalação e configuração em sistemas baseados em Red Hat.

## Pré-requisitos

Antes de utilizar este script, certifique-se de que os seguintes requisitos estejam instalados no seu sistema:

- [Git](https://git-scm.com/)
- [Go](https://go.dev/dl/)
- [NFPM](https://nfpm.goreleaser.com/)

## Como Usar

- Clone o Repositório:

```bash
git clone https://github.com/marcelobaptista/scripts.git
cd scripts/node-exporter-rpm
```

- Edite o arquivo build-rpm.sh preenchendo os valores desejados nas variáveis
- Execute o Script:

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

- Copie o arquivo .rpm para sua máquina
- Instale o Pacote RPM (exemplo):

```bash
# com o comando rpm
sudo rpm -ivh node_exporter-1.7.0.x86_64.rpm

# com o gerenciador yum
sudo yum install node_exporter-1.7.0.x86_64.rpm
```
