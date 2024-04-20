#!/bin/bash

# Define variáveis. Não use espaços em branco, apenas underline.
version=1.7.0
revision=1.7.0
branch=main
build_user=marcelo@casa
# A variável $tags aceita espaços em branco.
tags="tags"

# Porta a ser usada pelo Node Exporter
port=9100

# Diretório de instalação do Node Exporter a ser configurado no arquivo de serviço do Systemd
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

rm -rf node_exporter*

# Baixa o código fonte do Node Exporter
git clone https://github.com/prometheus/node_exporter.git

# Remove coletores de outros SO
find node_exporter/collector -type f \( -name "*bsd*" -o -name "*darwin*" -o -name "*dragonfly*" -o -name "*solaris*" \) -exec rm {} \;

# Coletores não padrão (desabilitados) do Node Exporter.
# Para manter um coletor, remova a linha correspondente.
# Para remover um coletor, mantenha a linha correspondente.
# https://github.com/prometheus/node_exporter#disabled-by-default

# Removendo coletores específicos:
rm -rf node_exporter/collector/buddyinfo.go \
    node_exporter/collector/cgroups_linux.go \
    node_exporter/collector/cpu_vulnerabilities_linux.go \
    node_exporter/collector/drbd_linux.go \
    node_exporter/collector/drm_linux.go \
    node_exporter/collector/ethtool_linux.go \
    node_exporter/collector/ethtool_linux_test.go \
    node_exporter/collector/interrupts_common.go \
    node_exporter/collector/interrupts_linux.go \
    node_exporter/collector/interrupts_linux_test.go \
    node_exporter/collector/ksmd_linux.go \
    node_exporter/collector/lnstat_linux.go \
    node_exporter/collector/logind_linux.go \
    node_exporter/collector/logind_linux_test.go \
    node_exporter/collector/meminfo_numa_linux.go \
    node_exporter/collector/meminfo_numa_linux_test.go \
    node_exporter/collector/mountstats_linux.go \
    node_exporter/collector/network_route_linux.go \
    node_exporter/collector/ntp.go \
    node_exporter/collector/perf_linux.go \
    node_exporter/collector/perf_linux_test.go \
    node_exporter/collector/processes_linux.go \
    node_exporter/collector/processes_linux_test.go \
    node_exporter/collector/qdisc_linux.go \
    node_exporter/collector/runit.go \
    node_exporter/collector/slabinfo_linux.go \
    node_exporter/collector/softirq_linux.go \
    node_exporter/collector/softirqs_common.go \
    node_exporter/collector/supervisord.go \
    node_exporter/collector/sysctl_linux.go \
    node_exporter/collector/systemd_linux.go \
    node_exporter/collector/systemd_linux_test.go \
    node_exporter/collector/tcpstat_linux.go \
    node_exporter/collector/tcpstat_linux_test.go \
    node_exporter/collector/wifi_linux.go \
    node_exporter/collector/zoneinfo_linux.go

# Coletores padrão do Node Exporter.
# Para manter um coletor, remova a linha correspondente.
# Para remover um coletor, mantenha a linha correspondente.
# Consulte: https://github.com/prometheus/node_exporter#enabled-by-default

# Removendo coletores específicos:
# rm -rf node_exporter/collector/arp_linux.go \
#     node_exporter/collector/bcache_linux.go \
#     node_exporter/collector/bonding_linux.go \
#     node_exporter/collector/bonding_linux_test.go \
#     node_exporter/collector/btrfs_linux.go \
#     node_exporter/collector/btrfs_linux_test.go \
#     node_exporter/collector/conntrack_linux.go \
#     node_exporter/collector/cpu_common.go \
#     node_exporter/collector/cpufreq_common.go \
#     node_exporter/collector/cpufreq_linux.go \
#     node_exporter/collector/cpu_linux.go \
#     node_exporter/collector/cpu_linux_test.go \
#     node_exporter/collector/diskstats_common.go \
#     node_exporter/collector/diskstats_linux.go \
#     node_exporter/collector/diskstats_linux_test.go \
#     node_exporter/collector/dmi.go \
#     node_exporter/collector/edac_linux.go \
#     node_exporter/collector/entropy_linux.go \
#     node_exporter/collector/fibrechannel_linux.go \
#     node_exporter/collector/filefd_linux.go \
#     node_exporter/collector/filefd_linux_test.go \
#     node_exporter/collector/filesystem_common.go \
#     node_exporter/collector/filesystem_linux.go \
#     node_exporter/collector/filesystem_linux_test.go \
#     node_exporter/collector/helper.go \
#     node_exporter/collector/helper_test.go \
#     node_exporter/collector/hwmon_linux.go \
#     node_exporter/collector/infiniband_linux.go \
#     node_exporter/collector/ipvs_linux.go \
#     node_exporter/collector/ipvs_linux_test.go \
#     node_exporter/collector/loadavg.go \
#     node_exporter/collector/loadavg_linux.go \
#     node_exporter/collector/loadavg_linux_test.go \
#     node_exporter/collector/mdadm_linux.go \
#     node_exporter/collector/meminfo.go \
#     node_exporter/collector/meminfo_linux.go \
#     node_exporter/collector/meminfo_linux_test.go \
#     node_exporter/collector/netclass_linux.go \
#     node_exporter/collector/netclass_rtnl_linux.go \
#     node_exporter/collector/netdev_common.go \
#     node_exporter/collector/netdev_linux.go \
#     node_exporter/collector/netdev_linux_test.go \
#     node_exporter/collector/netstat_linux.go \
#     node_exporter/collector/netstat_linux_test.go \
#     node_exporter/collector/nfsd_linux.go \
#     node_exporter/collector/nfs_linux.go \
#     node_exporter/collector/nvme_linux.go \
#     node_exporter/collector/os_release.go \
#     node_exporter/collector/os_release_test.go \
#     node_exporter/collector/paths.go \
#     node_exporter/collector/paths_test.go \
#     node_exporter/collector/powersupplyclass.go \
#     node_exporter/collector/powersupplyclass_linux.go \
#     node_exporter/collector/pressure_linux.go \
#     node_exporter/collector/rapl_linux.go \
#     node_exporter/collector/schedstat_linux.go \
#     node_exporter/collector/selinux_linux.go \
#     node_exporter/collector/sockstat_linux.go \
#     node_exporter/collector/softnet_linux.go \
#     node_exporter/collector/stat_linux.go \
#     node_exporter/collector/tapestats_linux.go \
#     node_exporter/collector/textfile.go \
#     node_exporter/collector/textfile_test.go \
#     node_exporter/collector/thermal_zone_linux.go \
#     node_exporter/collector/time.go \
#     node_exporter/collector/time_linux.go \
#     node_exporter/collector/time_other.go \
#     node_exporter/collector/timex.go \
#     node_exporter/collector/udp_queues_linux.go \
#     node_exporter/collector/uname.go \
#     node_exporter/collector/uname_linux.go \
#     node_exporter/collector/vmstat_linux.go \
#     node_exporter/collector/xfs_linux.go \
#     node_exporter/collector/zfs.go \
#     node_exporter/collector/zfs_linux.go \
#     node_exporter/collector/zfs_linux_test.go

sed -i "s/Version=.*/Version=${version}/g; \
        s/Revision=.*/Revision=${revision}/g; \
        s/Branch=.*/Branch=${branch}/g; \
        s/BuildUser=.*/BuildUser=${build_user}/g; \
        s/BuildDate=.*/BuildDate={{date \"02\/01\/2006\"}}/g; \
        s/-tags.*/-tags '${tags}'/g" "node_exporter/.promu.yml"

# Compila o Node Exporter
cd node_exporter && GOOS=linux GOARCH="${arch}" make build node_exporter
shopt -s dotglob extglob 
rm -rf !(node_exporter)

# Cria o arquivo do serviço do Node Exporter para o Systemd
cat <<EOF >node_exporter.service
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

# Cria arquivo de configuração do Node Exporter
# Consulte https://github.com/prometheus/node_exporter para mais opções de configuração
cat <<EOF >node_exporter.conf
OPTIONS="--web.disable-exporter-metrics \
--web.listen-address=:${port}"
EOF