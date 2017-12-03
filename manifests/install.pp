# Class Certificate_distribution::Install
#
# Install the certificates based on the configuration given by init.pp
# 
class certificate_distribution::install inherits certificate_distribution {
  package { 'ca-certificates': ensure => installed; }
  # classic configuration files containing CA trust bundles in the PEM or JAVA keystore file formats are replaced with symbolic
  # links that resolve to consolidated and dynamically updated files below the /etc/pki/ca-trust/extracted directory hierarchy.
  -> exec { 'enable update-ca-trust':
    command => '/usr/bin/update-ca-trust force-enable',
    onlyif  => '/usr/bin/update-ca-trust check | /bin/grep "DISABLED"',
  }
  -> certificate_distribution::certificate { $::certificate_distribution::certificate_list: }

  # learn new ca
  exec { 'update ca-trust':
    command     => '/usr/bin/update-ca-trust extract',
    refreshonly => true,
  }
}
