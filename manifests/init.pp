# Class: certificate_distribution
#
# This module manages certificate_distibution for RHEL6.
# 
# The certificates that are included in the files folder are distributed to the assigned machines.
#
# certificate_list is the list of names of the files that should be deployed
# source is the puppet source path of the files to be deployed. Defaults to: 
class certificate_distribution (
  Array  $certificate_list = $certificate_distribution::params::certificate_list,
  String $source           = $certificate_distribution::params::source,
  String $certificate_dir  = $certificate_distribution::params::certificate_dir,
) inherits
certificate_distribution::params {
  class { 'certificate_distribution::install': }
  -> Class['::certificate_distribution']
}
