#
# Cookbook Name:: postgresql
# Recipe::apt_postgresql_ppa
#
# Copyright 2012, Coroutine LLC
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

# Add the PostgreSQL 9.1 sources for Ubuntu
# using the PPA available at:
# https://launchpad.net/~pitti/+archive/postgresql

# NOTE: This requires the "apt" recipe
case node["platform"]
when "ubuntu"
  file "remove deprecated Pitti PPA apt repository" do
    action :delete
    path "/etc/apt/sources.list.d/postgresql-source"
  end

  apt_repository "apt.postgresql.org" do
    uri 'http://apt.postgresql.org/pub/repos/apt'
    distribution "#{node['lsb']['codename']}-pgdg"
    components ["main", node['postgresql']['version']]
    key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
    action :add
  end
end
