#
# Cookbook Name:: lemur
# Spec:: _dependencies
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

describe 'lemur::_dependencies' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    it 'includes apt::default recipe' do
      expect(chef_run).to include_recipe('apt::default')
    end

    %w(
      nodejs-legacy
      python-pip
      python-dev
      libpq-dev
      build-essential
      libssl-dev
      libffi-dev
      nginx
      git
      supervisor
      npm
      postgresql
    ).each do |pkg|
      it "installs #{pkg} dependency" do
        expect(chef_run).to upgrade_package(pkg)
      end
    end
  end
end
