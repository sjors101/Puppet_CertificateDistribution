# Class Certificate_distribution::Params
#
# Defaults variables
class certificate_distribution::params {
  $certificate_list = ['test.cacert.pem']
  $source = 'puppet:///modules/certificate_distribution/'
}
