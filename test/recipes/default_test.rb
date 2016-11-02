# # encoding: utf-8

# Inspec test for recipe lemur::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command('apt-get install curl')

describe user('lemur') do
  it { should exist }
end

describe port(80) do
  it { should be_listening }
end

%w{
  postgresql
  lemur
}.each do |svc|
  describe service(svc) do
    it { should be_enabled }
    it { should be_running }
  end
end

# rubocop:disable LineLength
login_cmd = "curl -X POST -d '{\"username\":\"lemur\",\"password\":\"lemur\"}' -v -H 'Content-Type: application/json' http://localhost:80/api/1/auth/login"
# rubocop:enable LineLength
describe command(login_cmd) do
  its('stderr') { should match /HTTP\/1\.1 200 OK/ }
  its('stdout') { should match /token/ }
end
