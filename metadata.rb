name 'nexus'
maintainer 'Alberto Cortes'
maintainer_email 'alcortes01@gmail.com'
license 'MIT'
description 'Installs/Configures nexus'
long_description 'Installs/Configures nexus'
version '1.0.0'

chef_version '>= 14.0'
%w(centos redhat).each do |os|
  supports os
end

issues_url 'https://github.com/alcortes01/nexus/issues'

source_url 'https://github.com/alcortes01/nexus'
