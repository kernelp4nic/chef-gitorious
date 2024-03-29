#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2010, Opscode, Inc.
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
#

package "vim-nox"

cookbook_file("/etc/vim/vimrc.local"){ source "vimrc.local" }

node[:vim][:extra_packages].each do |vimpkg|
  package vimpkg
end

update_editor = lambda { execute "update-alternatives --set editor /usr/bin/vim.nox" }
ruby_block("Update editor alternatives to vim") do
  block &update_editor
  not_if { File.identical? '/etc/alternatives/editor', '/usr/bin/vim.nox' }
end
