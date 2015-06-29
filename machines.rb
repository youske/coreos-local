#
# 仮想サーバ構成
#

# coreos 設定
$coreos_channel = "stable"
$coreos_version = "current"
$coreos_url = "http://%s.release.core-os.net/amd64-usr/%s/coreos_production_vagrant.json"


$env_config = {
  :general => {
    :box => "coreos-%s" % $coreos_channel,
    :box_url => $coreos_url % [$coreos_channel, $coreos_version],
    :box_version => $coreos_version,
    :box_update => true,
    :private_ipaddr => "192.168.33.20",
    :docker_expose_tcp => 2375,
    :intnet => "developvm",
    :common_bootstrap_path => "bootstrap.sh"
  },

  :roles => [
    {
      :active => true,
      :name => "manage",
      :cpus => 1,
      :memory => 256,
      :bind_ports => [],
      :mount => [ ["..","/app"] ],
      :gui => false,
      :bootstrap_path => 'bootstrap.sh'
    },
    {
      :active => false,
      :name => "frontend",
      :cpus => 1,
      :memory => 256,
      :bind_ports => [ [80,80],[8080,8080] ],
      :mount => [],
      :gui => false,
      :bootstrap_path => 'bootstrap.sh'
    },
    {
      :active => false,
      :name => "backend",
      :cpus => 1,
      :memory => 256,
      :bind_ports => [ [33306,33306] ],
      :mount => [],
      :gui => false,
      :bootstrap_path => 'bootstrap.sh'
    },
    {
      :active => false,
      :name => "cache",
      :cpus => 1,
      :memory => 256,
      :bind_ports => [ [11211,11211] ],
      :mount => [],
      :gui => false,
      :bootstrap_path => 'bootstrap.sh'
    },
    {
      :active => false,
      :name => "log",
      :cpus => 1,
      :memory => 256,
      :bind_ports => [ [80,80],[8080,8080] ],
      :mount => [],
      :gui => false,
      :bootstrap_path => 'bootstrap.sh'
    }
  ]
}
