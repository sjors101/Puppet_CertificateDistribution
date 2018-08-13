# Class Certificate_distribution::Install
#
# Install the certificates based on the configuration given by init.pp
# 
class certificate_distribution::install inherits certificate_distribution {
  package { 'ca-certificates': ensure => installed; }
  # classic configuration files containing CA trust bundles in the PEM or JAVA keystore file formats are replaced with symbolic
  # links that resolve to consolidated and dynamically updated files below the /etc/pki/ca-trust/extracted directory hierarchy.
  -> certificate_distribution::certificate {
    $::certificate_distribution::certificate_list:
      source => $::certificate_distribution::source
  }

  if $facts['os']['name'] == 'Redhat' or $facts['os']['name'] == 'CentOS' {
    exec { 'enable update-ca-trust':
      command => '/usr/bin/update-ca-trust force-enable',
      onlyif  => '/usr/bin/update-ca-trust check | /bin/grep "DISABLED"',
      path    => ['/bin', '/usr/bin', '/usr/sbin'],
    }

    Exec['enable update-ca-trust'] -> Certificate_distribution::Certificate <| |>
  }

  # learn new ca
  exec { 'update ca-trust':
    command     => $::certificate_distribution::trust_command,
    refreshonly => true,
    path        => ['/bin', '/usr/bin', '/usr/sbin'],
  }
}
