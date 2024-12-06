# Class Certificate_distribution::Install
#
# @summary Installs the certificates based on the configuration given by init.pp
#
# @api private
class certificate_distribution::install inherits certificate_distribution {
  package { 'ca-certificates': ensure => installed; }
  # classic configuration files containing CA trust bundles in the PEM or JAVA keystore file formats are replaced with symbolic
  # links that resolve to consolidated and dynamically updated files below the /etc/pki/ca-trust/extracted directory hierarchy.
  -> certificate_distribution::certificate {
    $certificate_distribution::certificate_list:
      source => $certificate_distribution::source,
  }

  # learn new ca
  exec { 'update ca-trust':
    command     => $certificate_distribution::trust_command,
    refreshonly => true,
    path        => ['/bin', '/usr/bin', '/usr/sbin'],
  }
}
