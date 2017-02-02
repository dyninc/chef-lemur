#
# Cookbook Name:: lemur
# Recipe:: _dependencies
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

include_recipe('apt::default')

nr = node['lemur']['nodejs']['repo']
if nr['enable']
  apt_repository "nodesource" do
    uri nr['uri']
    key nr['key']
    components nr['components']
    action :add
  end
end

node['lemur']['dependencies'].each do |pkg, ver|
  package pkg do
    action ver ? :install : :upgrade
    version ver
  end
end
