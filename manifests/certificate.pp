# Certificate_distribution::Certificate
#
# Used to deploy a certificate, should not be called directly
#
define certificate_distribution::certificate (String $source) {
  file { "/etc/pki/ca-trust/source/anchors/${name}":
    ensure => file,
    path   => "/etc/pki/ca-trust/source/anchors/${name}",
    source => "${source}${name}",
    notify => Exec['update ca-trust'],
  }
}
