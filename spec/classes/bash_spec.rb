require 'spec_helper'

describe 'bash' do
  let(:facts) do
    {
      :luser      => 'rafaelfranca',
      :boxen_home => '/opt/boxen'
    }
  end

  it do
    should contain_package('bash')
    should contain_package('bash-completion')

    should contain_file_line('add bash to /etc/shells').with({
      :path    => '/etc/shells',
      :line    => "#{facts[:boxen_home]}/homebrew/bin/bash",
      :require => 'Package[bash]'
    })

    should contain_osx_chsh('rafaelfranca').with({
      :shell   => "#{facts[:boxen_home]}/homebrew/bin/bash",
      :require => 'File_line[add bash to /etc/shells]'
    })
  end
end
