# InSpec test for recipe nexus::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

# install JDK
describe package('java-1.8.0-openjdk-headless') do
  it { should be_installed }
end

# installation folder exist
describe directory('/opt/nexus') do
  its('type') { should cmp 'directory' }
end

# user created
describe user 'nexus' do
  it { should exist }
end

# modify nexus.rc
describe file ('/opt/nexus/bin/nexus.rc') do
  its ('content') { should match ('run_as_user="nexus"')}
end

# ownership nexus
describe directory ('/opt/nexus') do
  its ('owner') { should eq 'nexus'}
end

# ownership sonatype-work
describe directory ('/opt/sonatype-work') do
  its ('owner') { should eq 'nexus'}
end

# create systemd file
describe file ('/etc/systemd/system/nexus.service') do
  it { should exist }
end

# start the service
describe service('nexus') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

