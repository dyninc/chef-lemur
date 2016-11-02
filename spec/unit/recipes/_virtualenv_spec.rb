#
# Cookbook Name:: lemur
# Spec:: _virtualenv
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

describe 'lemur::_virtualenv' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    it 'creates lemur group and user' do
      expect(chef_run).to create_group('lemur')
      expect(chef_run).to create_user('lemur')
    end

    # FIXME: No matchers in poise-python
    # it 'configures lemur python runtime' do
    #   expect(chef_run).to create_python_runtime('lemur')
    # end

    it 'configures lemur python virtualenv' do
      expect(chef_run).to create_python_virtualenv('/home/lemur/venv')
    end

    it 'fixes virtualenv permissions' do
      resource = chef_run.bash('fix-venv-perms')
      expect(resource.code).to match(%r{\/bin\/chown -R lemur:lemur \.})
      expect(resource).to do_nothing
    end
  end
end
