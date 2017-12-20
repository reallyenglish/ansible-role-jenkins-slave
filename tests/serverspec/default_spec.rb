require "spec_helper"
require "serverspec"

packages = %w[jenkins rake phantomjs npm]
npm_packages = %w[jenkins]
user    = "jenkins"
group   = "jenkins"
home    = "/var/lib/jenkins"
ssh_checksum =
  "2048 SHA256:/dsTV9humya+2r8sgVyn9c6BGcMAhXftlv7+I34eObg\
 jenkins_master (RSA)"

case os[:family]
when "freebsd"
  home = "/usr/local/jenkins"
  packages = %w[jenkins rubygem-rake phantomjs npm]
when "ubuntu"
  if Gem::Version.new(os[:release]) <= Gem::Version.new("14.04")
    ssh_checksum =
      "2048 a0:b5:8a:3b:5f:8c:eb:5c:fc:17:65:6a:c2:64:33:f7\
  jenkins_master (RSA)"
  end
when "redhat"
  packages = %w[jenkins rubygem-rake npm]
  npm_packages = %w[phantomjs]
  if Gem::Version.new(os[:release]) <= Gem::Version.new("7.3.1611")
    ssh_checksum =
      "2048 a0:b5:8a:3b:5f:8c:eb:5c:fc:17:65:6a:c2:64:33:f7\
  jenkins_master (RSA)"
  end
end

packages.each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

npm_packages.each do |npm_package|
  describe command("npm list --global #{npm_package}") do
    its(:stdout) { should match(/#{npm_package}/) }
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

describe command("ssh-keygen -lf #{home}/.ssh/authorized_keys") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^#{Regexp.escape(ssh_checksum)}$/) }
  its(:stderr) { should match(/^$/) }
end

describe file("#{home}/.ansible_vault_key") do
  it { should exist }
  it { should be_mode 600 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  its(:content) { should match(/^QriBECUJGKBq4a1fMTMClAqqqaGuH8DG6jujJllw$/) }
end
