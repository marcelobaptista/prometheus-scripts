#!/bin/bash

# Diretório de instalação do Node Exporter
bin_dir="/opt/node_exporter"

# Define a arquitetura do sistema
arch=$(uname -m)
case $arch in
armv5*) arch="armv5" ;;
armv6*) arch="armv6" ;;
armv7*) arch="arm" ;;
aarch64) arch="arm64" ;;
x86) arch="386" ;;
x86_64) arch="amd64" ;;
i686) arch="386" ;;
i386) arch="386" ;;
*)
    echo "Arquitetura não suportada"
    exit 1
    ;;
esac

# Solicitação da porta ao usuário
while true; do
    printf "Porta a ser usada pelo Node Exporter (padrão: 9100): "
    read -r port

    # Verifica se o usuário digitou uma porta válida
    if [[ -z $port ]]; then
        port=9100
        break
    elif [[ $port =~ ^[0-9]+$ ]]; then
        break
    else
        echo "Por favor, digite um número de porta válido."
    fi
done

# Baixa a última versão do Node Exporter e extrai a versão
version=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep tag_name | cut -d '"' -f 4)
node_exporter_version=$(echo "${version}" | cut -d 'v' -f 2)

# Baixa o Node Exporter
curl -LO "https://github.com/prometheus/node_exporter/releases/download/${version}/node_exporter-${node_exporter_version}.linux-${arch}.tar.gz"

# Descompacta o Node Exporter
tar -xvf node_exporter-"${node_exporter_version}.linux-${arch}.tar.gz"

# Verifica se o diretório de destino existe, se não existir, cria
if [ ! -d "${bin_dir}" ]; then
    mkdir -p "${bin_dir}"
fi

# Verifica se o binário do Node Exporter já existe no local
if [ -e "${bin_dir}/node_exporter" ]; then
    rm "${bin_dir}/node_exporter"
fi

# Copia o binário do Node Exporter para o diretório de instalação
cp node_exporter-"${node_exporter_version}.linux-${arch}/node_exporter" "${bin_dir}"

# Verifica se o arquivo de configuração do Node Exporter já existe no local
unit_file=$(find / -name 'node_exporter.service' -print -quit)
if [[ -n "${unit_file}" ]]; then
    systemctl stop node_exporter
    systemctl disable node_exporter
    rm -f "${unit_file}"
fi

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
Type=simple
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
# Consulte https://github.com/prometheus/node_exporter para mais opções de configuração
cat <<EOF >"${bin_dir}/node_exporter.conf"
OPTIONS="--web.disable-exporter-metrics \
--web.listen-address=:${port}"
EOF

# Cria o usuário e grupo do Node Exporter caso não exista
if ! id -u node_exporter &>/dev/null; then
    useradd --no-create-home --shell /bin/false node_exporter &&
        chown -R node_exporter:node_exporter "${bin_dir}"
fi

# Cria link simbólico para o binário do Node Exporter no diretório /usr/bin caso não exista
if ! [ -e "/usr/bin/node_exporter" ]; then
    ln -s "${bin_dir}/node_exporter" /usr/bin/node_exporter
fi

# Habilita e inicia o serviço do Node Exporter
systemctl daemon-reload && systemctl enable --now node_exporter.service

# Limpa arquivos temporários
rm node_exporter-"${node_exporter_version}.linux-${arch}.tar.gz"
rm -rf node_exporter-"${node_exporter_version}.linux-${arch}"
