require "spec_helper"
require "serverspec"

packages = %w(jenkins rake phantomjs)
user    = "jenkins"
group   = "jenkins"
home    = "/var/lib/jenkins"

case os[:family]
when "freebsd"
  home = "/usr/local/jenkins"
  packages = %w(jenkins rubygem-rake phantomjs)
when "redhat"
  packages = %w(jenkins rubygem-rake)
end

packages.each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

case os[:family]
when "redhat"
  describe command("npm list --global phantomjs") do
    its(:stdout) { should match(/phantomjs/) }
    its(:stderr) { should eq "" }
    its(:exit_status) { should eq 0 }
  end
end

describe user(user) do
  it { should exist }
end

describe group (group) do
  it { should exist }
end

describe file(home) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file("#{home}/.ssh") do
  it { should exist }
  it { should be_mode 700 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file("#{home}/.ssh/authorized_keys") do
  it { should exist }
  it { should be_mode 600 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file("#{home}/.ansible_vault_key") do
  it { should exist }
  it { should be_mode 600 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  its(:content) { should match(/^0123456789abcdefghijklmnopqrstuvwxyz$/) }
end
