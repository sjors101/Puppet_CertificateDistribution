# Certificate Distribution 
[![Build Status](https://travis-ci.org/sjors101/Puppet_CertificateDistribution.svg?branch=master)](https://travis-ci.org/sjors101/Puppet_CertificateDistribution)
This is the certificate_distibution module. This module manages certificate_distibution for RHEL.

Tested on...

 * RHEL 6
 * RHEL 7

## Example usage
 
The certificates that are included in the files folder and the $certifcates_list in params.pp are distributed to the assigned machines.
The name in the $certificate_list must be the same as the pem file.<br><br>
Example:

1. add the PEM file the the certificate_distribution/files/<br>
test.cacert.pem

2. add the new certificate to the params.pp<br>
$certificate_list = ["test.cacert.pem"] 

OR

Call the module:

```
class {'certificate_distribution':
  certificate_list => 'cachain.pem',
  source           => 'puppet:///modules/profile/certificates/'
}
```
