# certificate_distribution #
#
# This is the certificate_distibution module. This module manages certificate_distibution for RHEL.
#
## Tested on...

 * RHEL 6

## Example usage
 
# The certificates that are included in the files folder and the $certifcates_list in params.pp are distributed to the assigned machines.
# The name in the $certifcates_list must be the same as the pem file.
# Example:

 1. add the PEM file the the certificate_distribution/files/
 	test.cacert.pem

 2. add the new certifcate to the params.pp
 	$certifcates_list = ["test.cacert.pem"] 