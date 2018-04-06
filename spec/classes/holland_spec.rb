require 'spec_helper'

describe 'holland' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('holland::params') }
      it { is_expected.to contain_class('holland::install') }
      it { is_expected.to contain_class('holland::setup') }
      it { is_expected.to contain_class('holland::backupsets') }

      context 'holland::install' do
        it { is_expected.to contain_package('holland').with_ensure('present') }
        it { is_expected.to contain_package('holland-common').with_ensure('present') }
        it { is_expected.to have_resource_count(2) }

        context "remove packages if package_ensure => 'absent'" do
          let(:params) { { package_ensure: 'absent' } }
          it { is_expected.to contain_package('holland').with_ensure('absent') }
          it { is_expected.to contain_package('holland-common').with_ensure('absent') }
        end

        context "keep packages at latest version if package_ensure => 'latest'" do
          let(:params) { { package_ensure: 'latest' } }
          it { is_expected.to contain_package('holland').with_ensure('latest') }
          it { is_expected.to contain_package('holland-common').with_ensure('latest') }
        end

        context "use alternate package prefix if package_prefix => 'testing-'" do
          let(:params) { { package_prefix: 'testing-' } }
          it { is_expected.to contain_package('holland').with_ensure('present') }
          it { is_expected.to contain_package('testing-common').with_ensure('present') }
        end

        describe 'allows modules to be overridden' do
          let(:params) { { modules: { 'mysql' => {} } } }

          it { is_expected.to contain_package('holland-mysql') }
          it { is_expected.to have_resource_count(3) }
        end
      end

      context 'holland::setup' do
        it { is_expected.to contain_file('/etc/holland/holland.conf') }
      end
    end
  end
end
