#
# Cookbook Name:: lemur
# Recipe:: virtualenv
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

# The run_action is here to ensure this user and group are created in advance
# of the lemur::secrets files getting configured on disk.
group vc["group"] do
  gid vc["gid"]
  system true
end.run_action(:create)

user vc["user"] do
  comment "Lemur system user"
  manage_home true
  system true
  uid vc["uid"]
  gid vc["group"]
  home vc["home"]
end.run_action(:create)

# FIXME: Can't use system provider, since lemur user needs to install python
# libraries. Not sure portable_pypy is the answer, but seems most likely.
python_runtime "lemur" do
  provider vc["provider"]
  version vc["version"]
  # options vc["provider"], url: vc["url"]
end

python_virtualenv ::File.join(vc["home"], vc["venv"]) do
  user vc["user"]
  group vc["group"]
  pip_version vc["pip_version"]
  setuptools_version vc["setuptools_version"]
  wheel_version vc["wheel_version"]
  python "lemur"
end
