#
# Cookbook Name:: lemur
# Spec:: default
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

describe 'lemur::default' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    before do
      stub_command('ls /var/lib/postgresql/9.3/main/recovery.conf').and_return(
        0
      )
      allow(::File).to receive(:exists?).and_call_original
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:exists?).with(
        '/home/lemur/.lemur/flask_secret_key'
      ).and_return(false)
      allow(::File).to receive(:exists?).with(
        '/home/lemur/.lemur/lemur_token_secret'
      ).and_return(false)
      allow(::File).to receive(:exists?).with(
        '/home/lemur/.lemur/lemur_encryption_keys'
      ).and_return(false)
      allow(::File).to receive(:exists?).with(
        '/home/lemur/.lemur/postgres_password'
      ).and_return(false)
      allow(::File).to receive(:read).with(
        '/home/lemur/.lemur/postgres_password'
      ).and_return('password')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    %w(
      _dependencies
      _virtualenv
      _nginx
      _lemur
      _config
      _postgres
      _service
    ).each do |recipe|
      it "includes #{recipe} recipe" do
        expect(chef_run).to include_recipe("lemur::#{recipe}")
      end
    end
  end
end
