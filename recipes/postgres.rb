#
# Cookbook Name:: lemur
# Recipe:: postgres
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

dc = node["lemur"]["lemur"]["config"]["sqlalchemy_database_uri"]
vc = node["lemur"]["virtualenv"]

include_recipe("postgresql::server") if node["lemur"]["feature_flags"]["postgres"]
include_recipe("database::postgresql") if node["lemur"]["feature_flags"]["postgres"]

postgres_connection_info = {
  :host      => dc["host"],
  :port      => dc["port"],
  :username  => "postgres"
}

# create a postgresql database
postgresql_database dc["database"] do
  connection postgres_connection_info
  action :create
  only_if { node["lemur"]["feature_flags"]["postgres"] }
end

# Create a postgresql user but grant no privileges
postgresql_database_user dc["user"] do
  connection postgres_connection_info
  password ::File.read(::File.join(vc["home"], ".lemur", "postgres_password"))
  database_name dc["database"]
  action     :create
  only_if { node["lemur"]["feature_flags"]["postgres"] }
end
