# rubocop:disable LineLength
name 'lemur'
maintainer 'Neil Schelly'
maintainer_email 'neil@neilschelly.com'
license 'apachev2'
description 'Installs/Configures lemur'
long_description 'Installs/Configures lemur'
version '1.0.4'
issues_url 'https://github.com/dyninc/chef-lemur/issues' if respond_to?(:issues_url)
source_url 'https://github.com/dyninc/chef-lemur' if respond_to?(:source_url)

depends 'poise-python'
depends 'apt'
depends 'nginx'
depends 'postgresql', '>= 3.4.6'
depends 'database', '~> 6.0.0'
depends 'cron', '>= 1.4.0'

# Used by nginx cookbook.
# If unconstrained, goes to incompatible 4.x release of ohai
depends 'ohai', '~> 2.0'
