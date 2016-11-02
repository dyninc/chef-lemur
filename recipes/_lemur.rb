#
# Cookbook Name:: lemur
# Recipe:: _lemur
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

lc = node['lemur']['lemur']
vc = node['lemur']['virtualenv']

directory ::File.join(vc['home'], lc['app']) do
  user vc['user']
  group vc['group']
  recursive true
end

git ::File.join(vc['home'], lc['app']) do
  repository lc['repository']
  revision lc['revision']
  group vc['group']
  user vc['user']
  action :sync
  notifies :run, 'bash[lemur-develop]', :immediately
end

bash 'lemur-develop' do
  action :nothing
  user vc['user']
  group vc['group']
  cwd ::File.join(vc['home'], lc['app'])
  code <<-EOH
    source #{::File.join(vc['home'], vc['venv'], 'bin', 'activate')}
    make develop
  EOH
  environment 'HOME' => vc['home']
  notifies :restart, 'service[lemur]'
end

cron_d 'lemur-sync' do
  minute  '*/15'
  command '/home/lemur/venv/bin/lemur sync -s all'
  user    vc['user']
end

cron_d 'lemur-check-revoked' do
  minute '*/15'
  command '/home/lemur/venv/bin/lemur check_revoked'
  user vc['user']
end

cron_d 'lemur-notify' do
  minute '*/15'
  command '/home/lemur/venv/bin/lemur notify'
  user vc['user']
end
