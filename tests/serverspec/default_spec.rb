require 'spec_helper'
require 'serverspec'

package = 'jenkins-slave'
service = 'jenkins-slave'
config  = '/etc/jenkins-slave/jenkins-slave.conf'
user    = 'jenkins-slave'
group   = 'jenkins-slave'
ports   = [ PORTS ]
log_dir = '/var/log/jenkins-slave'
db_dir  = '/var/lib/jenkins-slave'

case os[:family]
when 'freebsd'
  config = '/usr/local/etc/jenkins-slave.conf'
  db_dir = '/var/db/jenkins-slave'
end

describe package(package) do
  it { should be_installed }
end 

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape('jenkins-slave') }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

case os[:family]
when 'freebsd'
  describe file('/etc/rc.conf.d/jenkins-slave') do
    it { should be_file }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
