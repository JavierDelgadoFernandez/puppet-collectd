# https://collectd.org/wiki/index.php/Plugin:SNMP
define collectd::plugin::snmp::data (
  $instance,
  $type,
  $values,
  $ensure         = 'present',
  $instanceprefix = undef,
  $scale          = undef,
  $shift          = undef,
  $table          = false,
  $ignore         = undef,
  $invertmatch    = false,
) {

  include ::collectd
  include ::collectd::plugin::snmp

  $table_bool = str2bool($table)
  $invertmatch_bool = str2bool($invertmatch)
  $conf_dir   = $collectd::plugin_conf_dir
  $root_group = $collectd::root_group

  file { "snmp-data-${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/15-snmp-data-${name}.conf",
    owner   => 'root',
    group   => $root_group,
    mode    => '0640',
    content => template('collectd/plugin/snmp/data.conf.erb'),
    notify  => Service['collectd'];
  }
}
