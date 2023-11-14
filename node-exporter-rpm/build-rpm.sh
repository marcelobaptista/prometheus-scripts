#!/bin/bash

# Define variáveis. Não use espaços em branco, apenas underline.
version=1.7.0
revision=1.7.0
branch=main
build_user=marcelo@casa
# A variável $tags aceita espaços em branco.
tags="tags"

rm -f node_exporter* && mkdir -p temp RPMs

# Baixa o código fonte do Node Exporter
cd temp && git clone https://github.com/prometheus/node_exporter.git

# Remove coletores de outros SO
find node_exporter/collector -type f \( -name "*bsd*" -o -name "*darwin*" -o -name "*dragonfly*" -o -name "*solaris*" \) -exec rm {} \;

# Remove coletores não padrão (desabilitados) do Node Exporter, exceto systemd. Altere conforme necessário
# https://github.com/prometheus/node_exporter#disabled-by-default
rm -rf node_exporter/collector/fixtures/{ethtool,qdisc,wifi}
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
    node_exporter/collector/tcpstat_linux.go \
    node_exporter/collector/tcpstat_linux_test.go \
    node_exporter/collector/wifi_linux.go \
    node_exporter/collector/zoneinfo_linux.go

# Coletores padrão do Node Exporter.
# Descomente para remover coletores conforme necessário e se saber o que está fazendo.
# https://github.com/prometheus/node_exporter#disabled-by-default

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
make -C node_exporter build

# Ctia o serviço do Node Exporter
cat <<"EOF" >../node_exporter.service
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
EnvironmentFile=-/opt/node_exporter/node_exporter.conf
ExecStart=/opt/node_exporter/node_exporter $NODE_EXPORTER_ARGS 
ExecReload=/bin/kill -HUP $MAINPID
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
CPUAccounting=yes
MemoryAccounting=yes

[Install]
WantedBy=multi-user.target
EOF

# Cria arquivo de configuração do Node Exporter
cat <<"EOF" >../node_exporter.conf
NODE_EXPORTER_ARGS="--web.disable-exporter-metrics \
--web.listen-address=:9100"
EOF

# Copia o binário do Node Exporter
cp -f ./node_exporter/node_exporter ../ && cd ..

# Altera o arquivo de configuração do nfpm
sed -i "s/version:.*/version: ${version}/g" nfpm.yaml

# Cria o pacote RPM
nfpm pkg --packager rpm --target RPMs/

# Limpa o ambiente
rm -rf temp node_exporter node_exporter.service node_exporter.conf
