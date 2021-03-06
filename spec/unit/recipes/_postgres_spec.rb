#
# Cookbook Name:: lemur
# Spec:: _postgres
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

require 'spec_helper'

describe 'lemur::_postgres' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    before do
      stub_command('ls /var/lib/postgresql/9.3/main/recovery.conf').and_return(
        0
      )
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:read).with(
        '/home/lemur/.lemur/postgres_password'
      ).and_return('password')
    end
    it 'installs PostgreSQL with postgresql::server recipe' do
      expect(chef_run).to include_recipe('postgresql::server')
    end

    it 'configures PostgreSQL with database::postgresql recipe' do
      expect(chef_run).to include_recipe('database::postgresql')
    end

    it 'creates postgresql database called lemur' do
      expect(chef_run).to create_postgresql_database('lemur')
    end

    it 'creates postgresql user called lemur' do
      expect(chef_run).to create_postgresql_database_user('lemur')
    end

    it 'installs expect for configuring database with default user' do
      expect(chef_run).to install_package('expect')
    end

    it 'initializes lemur database and login' do
      expect(chef_run).to run_script('lemur-initialize')
    end
  end
end
