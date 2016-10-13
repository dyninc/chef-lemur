name 'lemur'
maintainer 'Neil Schelly'
maintainer_email 'neil@neilschelly.com'
license 'apachev2'
description 'Installs/Configures lemur'
long_description 'Installs/Configures lemur'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/lemur/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/lemur' if respond_to?(:source_url)

depends "poise-python"
depends "apt"
depends "nginx"
