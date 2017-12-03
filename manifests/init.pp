# Class: certificate_distribution
#
# This module manages certificate_distibution for RHEL6.
# 
# The certificates that are included in the files folder are distributed to the assigned machines.
#
class certificate_distribution ($certificate_list = $certificate_distribution::params::certificate_list,) inherits
certificate_distribution::params {
  class { 'certificate_distribution::install': }
  -> Class['::certificate_distribution']
}
