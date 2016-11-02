#
# Cookbook Name:: lemur
# Recipe:: _postgres
#
# Copyright 2016 Neil Schelly
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

dc = node['lemur']['lemur']['config']['sqlalchemy_database_uri']
vc = node['lemur']['virtualenv']
lc = node['lemur']['lemur']

# rubocop:disable LineLength
include_recipe('postgresql::server') if node['lemur']['feature_flags']['postgres']
include_recipe('database::postgresql') if node['lemur']['feature_flags']['postgres']
# rubocop:enable LineLength

postgres_connection_info = {
  host: dc['host'],
  port: dc['port'],
  username: 'postgres'
}

# create a postgresql database for lemur
postgresql_database dc['database'] do
  connection postgres_connection_info
  action :create
  only_if { node['lemur']['feature_flags']['postgres'] }
end

# Create a postgresql user for lemur
postgresql_database_user dc['user'] do
  connection postgres_connection_info
  password ::File.read(::File.join(vc['home'], '.lemur', 'postgres_password'))
  database_name dc['database']
  action :create
  only_if { node['lemur']['feature_flags']['postgres'] }
end

# Initialize Lemur database with lemur/lemur default credentials
package 'expect'
script 'lemur-initialize' do
  interpreter 'expect'
  action :run
  user vc['user']
  group vc['group']
  cwd ::File.join(vc['home'], lc['app'], 'lemur')
  code <<-EOH
    log_file #{::File.join(vc['home'], '.lemur', 'db_init.log')}
    spawn #{::File.join(vc['home'], vc['venv'], 'bin', 'lemur')} init
    set timeout 30
    expect "Password: " { send "lemur\r" }
    expect "Confirm Password: " { send "lemur\r" }
    expect eof
  EOH
  creates ::File.join(vc['home'], '.lemur', 'db_init.log')
  environment 'HOME' => vc['home']
  only_if { node['lemur']['feature_flags']['postgres'] }
end
