#
# Cookbook Name:: lemur
# Spec:: _secrets
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

describe 'lemur::_secrets' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    before do
      allow(::File).to receive(:exists?).and_call_original
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
    end

    %w(
      flask_secret_key
      lemur_token_secret
      lemur_encryption_keys
      postgres_password
    ).each do |secretfile|
      it "creates /home/lemur/.lemur/#{secretfile}" do
        expect(chef_run).to create_file_if_missing(
          "/home/lemur/.lemur/#{secretfile}"
        ).with('sensitive' => true)
      end
    end
  end
end
