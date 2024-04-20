#!/bin/bash

# Aplica permissões no diretório '/opt/node_exporter'
chown -R node_exporter:node_exporter /opt/node_exporter

# Recarrega o daemon do systemd e habilita o serviço do Node Exporter
systemctl daemon-reload && systemctl enable --now node_exporter
