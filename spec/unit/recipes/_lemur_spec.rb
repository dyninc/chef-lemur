#
# Cookbook Name:: lemur
# Spec:: _lemur
#
# Copyright 2016 Neil Schelly
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe 'lemur::_lemur' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge('lemur::_service', described_recipe)
    end

    it 'creates app directory' do
      expect(chef_run).to create_directory('/home/lemur/app')
    end

    it 'syncs lemur git repository' do
      expect(chef_run).to sync_git('/home/lemur/app')
    end

    it 'runs `lemur release` to setup lemur app' do
      resource = chef_run.bash('lemur-release')
      expect(resource.code).to match(/make release/)
      expect(resource).to do_nothing
    end

    it 'creates cron jobs for lemur' do
      expect(chef_run).to create_cron_d('lemur-sync')
      expect(chef_run).to create_cron_d('lemur-check-revoked')
      expect(chef_run).to create_cron_d('lemur-notify')
    end
  end
end
