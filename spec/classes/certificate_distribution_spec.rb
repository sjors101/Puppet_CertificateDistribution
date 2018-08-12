require 'spec_helper'
describe 'certificate_distribution' do
  on_supported_os.each do |os, os_facts|
    context "simple default unit test on #{os}" do
      let(:facts) { os_facts }

      it {
        is_expected.to contain_class('certificate_distribution')
        is_expected.to contain_package('ca-certificates')
        
        case facts[:osfamily]
        when 'RedHat'
          is_expected.to contain_exec('update ca-trust').with(
            'command' => 'update-ca-trust extract',
            'refreshonly' => true,
          )
          is_expected.to contain_file('certificate test.cacert.pem').with(
            'source' => 'puppet:///modules/certificate_distribution/test.cacert.pem',
            'path'   => '/etc/pki/ca-trust/source/anchors/test.cacert.pem',
          )
        when 'Debian'
          is_expected.to contain_exec('update ca-trust').with(
            'command' => 'update-ca-certificates',
            'refreshonly' => true,
          )
          is_expected.to contain_file('certificate test.cacert.pem').with(
            'source' => 'puppet:///modules/certificate_distribution/test.cacert.pem',
            'path'   => '/usr/local/share/ca-certificates/test.cacert.pem',
          )
        end
      }
    end

    context "Deploy two certificates on #{os}" do
      let(:facts) { os_facts }
      let(:params) { { certificate_list: ['test_ca1', 'test_ca2'] } }
  
      it {
        is_expected.to contain_class('certificate_distribution')
        is_expected.to contain_package('ca-certificates')
        case facts[:osfamily]
        when 'RedHat'
          is_expected.to contain_exec('update ca-trust').with(
            'command' => 'update-ca-trust extract',
            'refreshonly' => true,
          )
          is_expected.to contain_file('certificate test_ca1').with(
            'source' => 'puppet:///modules/certificate_distribution/test_ca1',
            'path'   => '/etc/pki/ca-trust/source/anchors/test_ca1',
          )
          is_expected.to contain_file('certificate test_ca2').with(
            'source' => 'puppet:///modules/certificate_distribution/test_ca2',
            'path'   => '/etc/pki/ca-trust/source/anchors/test_ca2',
          )
        when 'Debian'
          is_expected.to contain_exec('update ca-trust').with(
            'command' => 'update-ca-certificates',
            'refreshonly' => true,
          )
          is_expected.to contain_file('certificate test_ca1').with(
            'source' => 'puppet:///modules/certificate_distribution/test_ca1',
            'path'   => '/usr/local/share/ca-certificates/test_ca1',
          )
          is_expected.to contain_file('certificate test_ca2').with(
            'source' => 'puppet:///modules/certificate_distribution/test_ca2',
            'path'   => '/usr/local/share/ca-certificates/test_ca2',
          )
        end
      }
    end
    context "Deploy with different source path on #{os}" do
      let(:facts) { os_facts }
      let(:params) { { certificate_list: ['test_ca3'], source: 'puppet:///modules/certificate_distribution/test/' } }
  
      it {
        is_expected.to compile

        case facts[:osfamily]
        when 'RedHat'
          is_expected.to contain_file('certificate test_ca3').with(
            'source' => 'puppet:///modules/certificate_distribution/test/test_ca3',
            'path'   => '/etc/pki/ca-trust/source/anchors/test_ca3',
          )
        when 'Debian'
          is_expected.to contain_exec('update ca-trust').with(
            'command' => 'update-ca-certificates',
            'refreshonly' => true,
          )
          is_expected.to contain_file('certificate test_ca3').with(
            'source' => 'puppet:///modules/certificate_distribution/test/test_ca3',
            'path'   => '/usr/local/share/ca-certificates/test_ca3',
          )
        end
      }
    end
  end

  
end
