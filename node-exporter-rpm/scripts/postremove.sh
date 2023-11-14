#!/bin/bash

# Remove o usuário 'node_exporter' se existir
if getent passwd node_exporter >/dev/null; then
  userdel node_exporter
fi

# Remove o grupo 'node_exporter' se existir
if getent group node_exporter >/dev/null; then
  groupdel node_exporter
fi

# Remove o diretório '/opt/node_exporter'
rm -rfv /opt/node_exporter

# Recarrega o daemon do systemd
systemctl daemon-reload
