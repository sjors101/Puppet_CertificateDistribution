require 'spec_helper'
describe 'certificate_distribution' do
  context 'with default values for all parameters' do
    it {
      is_expected.to contain_class('certificate_distribution')
      is_expected.to contain_package('ca-certificates')
      is_expected.to contain_exec('update ca-trust').with(
        'command' => '/usr/bin/update-ca-trust extract',
        'refreshonly' => true,
      )
      is_expected.to contain_file('/etc/pki/ca-trust/source/anchors/test.cacert.pem').with(
        'source' => 'puppet:///modules/certificate_distribution/test.cacert.pem',
      )
    }
  end

  context 'Deploy two certificates' do
    let(:params) { { certificate_list: ['test_ca1', 'test_ca2'] } }

    it {
      is_expected.to contain_class('certificate_distribution')
      is_expected.to contain_package('ca-certificates')
      is_expected.to contain_exec('update ca-trust').with(
        'command' => '/usr/bin/update-ca-trust extract',
        'refreshonly' => true,
      )
      is_expected.to contain_file('/etc/pki/ca-trust/source/anchors/test_ca1').with(
        'source' => 'puppet:///modules/certificate_distribution/test_ca1',
      )
      is_expected.to contain_file('/etc/pki/ca-trust/source/anchors/test_ca2').with(
        'source' => 'puppet:///modules/certificate_distribution/test_ca2',
      )
    }
  end
  context 'Deploy with different source path' do
    let(:params) { { certificate_list: ['test_ca3'], source: 'puppet:///modules/certificate_distribution/test/' } }

    it {
      is_expected.to compile
      is_expected.to contain_file('/etc/pki/ca-trust/source/anchors/test_ca3').with(
        'source' => 'puppet:///modules/certificate_distribution/test/test_ca3',
      )
    }
  end
end
