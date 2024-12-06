# Class: certificate_distribution
#
# @summary This module manages certificate_distibution for RHEL6.
#
# The certificates that are included in the files folder are distributed to the assigned machines.
# @param certificate_list
#   The list of names of the files that should be deployed
#
# @param source
#   The puppet source path of the files to be deployed. Defaults to:
#
# @param certificate_dir
#   Path where certificates should be stored
#
class certificate_distribution (
  Array  $certificate_list = $certificate_distribution::params::certificate_list,
  String $source           = $certificate_distribution::params::source,
  String $certificate_dir  = $certificate_distribution::params::certificate_dir,
) inherits certificate_distribution::params {
  class { 'certificate_distribution::install': }
  -> Class['certificate_distribution']
}
