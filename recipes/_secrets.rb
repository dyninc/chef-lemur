#
# Cookbook Name:: lemur
# Recipe:: _secrets
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

# EXPLANATION
# This file generates random secrets for Python, Flask, Postgres, and Lemur
# If these files are already populated, they will be left alone. This makes
# it easier for folks wrapping this cookbook to populate these secrets without
# storing secrets in node attributes.

require "securerandom"

vc = node["lemur"]["virtualenv"]

file ::File.join(vc["home"], ".lemur", "flask_secret_key") do
  user vc["user"]
  group vc["group"]
  mode "0600"
  action :create_if_missing
  content ::SecureRandom.base64(64)
  sensitive true
end

file ::File.join(vc["home"], ".lemur", "lemur_token_secret") do
  user vc["user"]
  group vc["group"]
  mode "0600"
  action :create_if_missing
  content ::SecureRandom.base64(64)
  sensitive true
end

file ::File.join(vc["home"], ".lemur", "lemur_encryption_keys") do
  user vc["user"]
  group vc["group"]
  mode "0600"
  action :create_if_missing
  # Python fernet library says: "Fernet key must be 32 url-safe base64-encoded bytes."
  content ::SecureRandom.base64(32)
  sensitive true
end

# The run_action is here to ensure this secret is written at compile time,
# and then it will be available to other resources for reading.
file ::File.join(vc["home"], ".lemur", "postgres_password") do
  user vc["user"]
  group vc["group"]
  mode "0600"
  action :create_if_missing
  content ::SecureRandom.hex(32)
  sensitive true
end.run_action(:create_if_missing)
