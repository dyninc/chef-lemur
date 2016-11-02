#
# Cookbook Name:: lemur
# Spec:: _nginx
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

describe 'lemur::_nginx' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    it 'includes nginx::default recipe' do
      expect(chef_run).to include_recipe('nginx::default')
    end

    it 'creates nginx site template for lemur' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/lemur')
    end

    # FIXME: No matcher for nginx site right now
    # Using 1.8.0 of nginx cookbook. Probably want 2.7.6, but need to check
    # it 'enables lemur site configuration in nginx' do
    #   expect(chef_run).to enable_nginx_site('lemur')
    # end
  end
end
