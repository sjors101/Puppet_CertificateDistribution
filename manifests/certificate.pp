define certificate_distribution::certificate {
  file { "/etc/pki/ca-trust/source/anchors/$name":
    ensure => file,
    source => "puppet:///modules/certificate_distribution/$name",
    notify => Exec['update ca-trust'],
  }
}