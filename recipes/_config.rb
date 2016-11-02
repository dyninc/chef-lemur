#
# Cookbook Name:: lemur
# Recipe:: _config
#
# Copyright 2016 Neil Schelly
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


vc = node["lemur"]["virtualenv"]

# The run_action is here to ensure this directory is created in advance
# of the lemur::secrets files getting configured on disk.
directory ::File.join(vc["home"], ".lemur") do
  user vc["user"]
  group vc["group"]
  recursive true  
end.run_action(:create)

include_recipe("lemur::secrets")

template ::File.join(vc["home"], ".lemur", "lemur.conf.py") do
  source "lemur.conf.py.erb"
  sensitive true
  notifies :restart, "service[lemur]"
end
