#!/bin/bash

# Verifica se o grupo 'node_exporter' existe e cria se não existir
if ! getent group node_exporter >/dev/null; then
  groupadd node_exporter
fi

# Verifica se o usuário 'node_exporter' existe e cria se não existir
if ! getent passwd node_exporter >/dev/null; then
  useradd -g node_exporter --no-create-home --shell /bin/false node_exporter
fi

# Verifica se o diretório '/opt/node_exporter' existe e cria se não existir
if [ ! -d "/opt/node_exporter" ]; then
  mkdir -p /opt/node_exporter
else
  rm -rf /opt/node_exporter && mkdir -p /opt/node_exporter
fi
