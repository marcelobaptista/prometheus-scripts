#!/bin/bash

# Diretório de instalação do Node Exporter
bin_dir="/opt/node_exporter"

# Baixa a última versão do Node Exporter e extrai a versão
version=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep tag_name | cut -d '"' -f 4)
node_exporter_version=$(echo "${version}" | cut -d 'v' -f 2)

# Baixa o Node Exporter
curl -LO "https://github.com/prometheus/node_exporter/releases/download/${version}/node_exporter-${node_exporter_version}.linux-amd64.tar.gz"

# Descompacta o Node Exporter
tar -xvf node_exporter-"${node_exporter_version}".linux-amd64.tar.gz

# Copia o binário do Node Exporter
mkdir -p /opt/node_exporter
cp node_exporter-"${node_exporter_version}".linux-amd64/node_exporter "${bin_dir}"

# Cria o serviço do Node Exporter
cat <<EOF >/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network-online.target
Wants=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Restart=on-failure
type=simple
RestartSec=3
EnvironmentFile=${bin_dir}/node_exporter.conf
ExecStart=${bin_dir}/node_exporter \$OPTIONS 
ExecReload=/bin/kill -HUP \$MAINPID
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
CPUAccounting=yes
MemoryAccounting=yes

[Install]
WantedBy=multi-user.target
EOF
chmod 664 /etc/systemd/system/node_exporter.service

# Cria arquivo de configuração do Node Exporter
cat <<"EOF" >"${bin_dir}/node_exporter.conf"
OPTIONS="--web.listen-address=:9100"
EOF

# Cria o usuário e grupo do Node Exporter
useradd --no-create-home --shell /bin/false node_exporter &&
    chown -R node_exporter:node_exporter "${bin_dir}"

# Cria link simbólico para o binário do Node Exporter
ln -s "${bin_dir}/node_exporter" /usr/bin/node_exporter

# Habilita e inicia o serviço do Node Exporter
systemctl daemon-reload && systemctl enable --now node_exporter.service

# Limpa arquivos temporários
rm node_exporter-"${node_exporter_version}".linux-amd64.tar.gz
rm -rf node_exporter-"${node_exporter_version}".linux-amd64