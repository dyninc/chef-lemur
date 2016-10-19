name 'lemur'
maintainer 'Neil Schelly'
maintainer_email 'neil@neilschelly.com'
license 'apachev2'
description 'Installs/Configures lemur'
long_description 'Installs/Configures lemur'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/dyninc/chef-lemur/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/dyninc/chef-lemur' if respond_to?(:source_url)

depends "poise-python"
depends "apt"
depends "nginx"
depends "postgresql", "~> 4.0.6"
depends "database", "~> 6.0.0"
depends "cron", "~> 3.0.0"

# Used by nginx cookbook. If unconstrained, goes to incompatible 4.x release of ohai
depends "ohai", "~> 2.0"
