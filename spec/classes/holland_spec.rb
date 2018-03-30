require 'spec_helper'

describe 'holland' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { ['include epel', 'include holland'] }

      describe 'when called with default parameters.' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('holland::params') }
        it { is_expected.to contain_class('holland::install') }
        it { is_expected.to contain_class('holland::setup') }
        it { is_expected.to contain_class('holland::backupsets') }
      end
    end
  end
end
