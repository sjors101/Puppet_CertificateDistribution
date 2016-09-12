require 'spec_helper'
describe 'certificate_distribution' do
  context 'with default values for all parameters' do
    it { 
    	should contain_class('certificate_distribution') 
    	should contain_package('ca-certificates')
    	should contain_exec('update ca-trust').with(
    		{
    			'command' => '/usr/bin/update-ca-trust extract',
    			'refreshonly' => true
    		}
    	)
    	should contain_file('/etc/pki/ca-trust/source/anchors/test.cacert.pem').with(
    		{
    			'source' => 'puppet:///modules/certificate_distribution/test.cacert.pem'
    		}
    	)
    }
  end
  
  context 'Deploy two certificates' do
 	let(:params) {{ :certificate_list => ['test_ca1', 'test_ca2'] }}
	it {
  		should contain_class('certificate_distribution')
  		should contain_package('ca-certificates')
  		should contain_exec('update ca-trust').with(
    		{
    			'command' => '/usr/bin/update-ca-trust extract',
    			'refreshonly' => true
    		}
    	)
		should contain_file('/etc/pki/ca-trust/source/anchors/test_ca1').with(
			{
				'source' => 'puppet:///modules/certificate_distribution/test_ca1'
			}
		)
		should contain_file('/etc/pki/ca-trust/source/anchors/test_ca2').with(
			{
				'source' => 'puppet:///modules/certificate_distribution/test_ca2'
			}
		)
  	}
  end
end
