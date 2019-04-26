#
# Cookbook:: qt
# Recipe:: default
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

qt5_config_path = "#{Chef::Config[:file_cache_path]}/qt5.qs"

cookbook_file qt5_config_path do
  source 'qt5.qs'
end

version = node['qt']['version']
major_version = version[0..version.length-3]

url_prefix = 'https://download.qt.io/official_releases/qt'
qt5_source = "#{url_prefix}/#{major_version}/#{version}/qt-opensource-windows-x86-#{version}.exe"
qt5_install_opt = "--script #{qt5_config_path}"

windows_package 'Qt' do
  extend Qt::HelperHelpers
  package_name "Qt #{version}"
  source node['qt']['source'] || qt5_source 
  checksum node['qt']['checksum'] if node['qt']['checksum']
  installer_type :custom
  action :install
  options qt5_install_opt
  timeout node['qt']['timeout'] || 1500
  not_if { is_local_system_user? }
end
