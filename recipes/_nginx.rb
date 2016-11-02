#
# Cookbook Name:: lemur
# Recipe:: _nginx
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

nc = node["lemur"]["nginx"]

node.default["nginx"]["default_site_enabled"] = false
include_recipe("nginx::default") if node["lemur"]["feature_flags"]["nginx"]

template "#{node["nginx"]["dir"]}/sites-available/lemur" do
  source nc["siteconfig_template"]
  cookbook nc["siteconfig_template_cookbook"]
  notifies :restart, "service[nginx]"
end

nginx_site "lemur" do 
  enable true
  only_if { node["lemur"]["feature_flags"]["nginx"] }
end
