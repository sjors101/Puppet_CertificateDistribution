# Certificate_distribution::Certificate
#
# @summary Used to deploy a certificate, should not be called directly
#
# @api private
define certificate_distribution::certificate (String $source) {
  file { "certificate ${name}":
    ensure => file,
    path   => "${certificate_distribution::certificate_dir}${name}",
    source => "${source}${name}",
    notify => Exec['update ca-trust'],
  }
}
