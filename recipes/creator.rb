#
# Cookbook:: qt
# Recipe:: creator
#
# Copyright:: 2019, Nghiem Ba Hieu
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

creator_config_path = "#{Chef::Config[:file_cache_path]}/qtcreator.qs"

version = node['qtcreator']['version']
major_version = version[0..version.length-3]

creator_url_prefix = 'https://download.qt.io/official_releases/qtcreator'
creator_source = if node['qtcreator']['edition'] == '64 bit'
                   "#{creator_url_prefix}/#{major_version}/#{version}/qt-creator-opensource-windows-x86_64-#{version}.exe"
                 else
                   "#{creator_url_prefix}/#{major_version}/#{version}/qt-creator-opensource-windows-x86-#{version}.exe"
                 end
creator_install_opt = "--script #{creator_config_path}"

template creator_config_path do
  source 'qtcreator.qs.erb'
  variables(
    version: node['qtcreator']['version']
  )
  action :create
end

windows_package 'Qt Creator' do
  extend Qt::HelperHelpers
  package_name "Qt Creator #{node['qtcreator']['version']} (#{node['qtcreator']['edition']})"
  source node['qtcreator']['source'] || creator_source
  checksum node['qtcreator']['checksum'] if node['qtcreator']['checksum']
  installer_type :custom
  action :install
  options creator_install_opt
  timeout node['qtcreator']['timeout'] || 1500
  not_if { is_local_system_user? }
end
