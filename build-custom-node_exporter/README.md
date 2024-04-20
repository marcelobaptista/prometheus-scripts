# Script de compilação personalizada do Node Exporter

Este script Bash compila o Node Exporter em distribuições Linux de forma personalizada, permitindo ajustes nas variáveis e habilitação ou desabilitação de coletores.

## Arquiteuras suportadas

- x86_32
- x86_64
- armv5
- armv6
- armv7
- arm64

## Pré-requisitos

Antes de utilizar este script, verifique se você possui os seguintes requisitos:

- [make](https://www.gnu.org/software/make): para compilar o Node Exporter.
- [curl](https://curl.se/download.html): para baixar o Node Exporter e suas dependências.

## Como Usar

1. **Clone o repositório e acesse a pasta `build-custom-node_exporter`:**

```bash
git clone https://github.com/marcelobaptista/prometheus-scripts.git
cd prometheus-scripts/build-custom-node_exporter
```
2. **Personalize as variáveis (Opcional):**

No início do script `build-node_exporter.sh`, existem variáveis que podem ser ajustadas conforme necessário. Essas variáveis incluem a versão, revisão, ramo, usuário de compilação, porta, diretório de instalação e tags. Exemplo abaixo após compilado:
```bash
$ node_exporter --version 
  node_exporter, version 1.7.0 (branch: main, revision: 1.7.0)
    build user:       marcelo@casa
    build date:       20/04/2024
    go version:       go1.22.2
    platform:         linux/amd64
    tags:             tags
```
3. **Habilite ou Desabilite Coletores (Opcional):**

É possível remover coletores específicos do Node Exporter. Para isso, basta comentar ou descomentar as linhas referentes aos coletores no arquivo `build-node_exporter.sh`.
Documentação: [Collectors](https://github.com/prometheus/node_exporter?tab=readme-ov-file#collectors)

4. **Forneça permissão de execução:**
```bash
chmod +x build-node_exporter.sh
```
5. **Compile o Node Exporter:**
```bash
build-node_exporter.sh
```
6. **Verifique a subpasta `node_exporter` criada:**

Após a compilação, serão criados os arquivos `node_exporter`, `node_exporter.conf` e `node_exporter.service` na subpasta `node_exporter`.
