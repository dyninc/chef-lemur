#
# Cookbook Name:: lemur
# Spec:: _config
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

describe 'lemur::_config' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge('lemur::_service', described_recipe)
    end

    it 'creates lemur configuration directory' do
      expect(chef_run).to create_directory('/home/lemur/.lemur')
    end

    it 'includes _secrets recipe' do
      expect(chef_run).to include_recipe('lemur::_secrets')
    end

    it 'creates lemur configuration template' do
      expect(chef_run).to create_template('/home/lemur/.lemur/lemur.conf.py')
    end
  end
end
