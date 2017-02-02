# Default attributes

# These all default to true, but can be disabled if you want to configure
# any of the pieces yourself, outside this cookbook.
default['lemur']['feature_flags'] = {
  'postgres' => true,
  'nginx' => true
}

default['lemur']['nodejs']['repo'] = {
  'uri' => 'https://deb.nodesource.com/node_6.x',
  'key' => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
  'components' => %w{main},
  'enable' => true
}

# Dependencies and versions
# nil versions will automatically upgrade
default['lemur']['dependencies'] = {
  'nodejs' => nil,
  'python-pip' => nil,
  'python-dev' => nil,
  'libpq-dev' => nil,
  'build-essential' => nil,
  'libssl-dev' => nil,
  'libffi-dev' => nil,
  'nginx' => nil,
  'git' => nil,
  'supervisor' => nil,
  'postgresql' => nil
}

# Setup Pytnon virtualenv
default['lemur']['virtualenv'] = {
  'user' => 'lemur',
  'group' => 'lemur',
  'home' => '/home/lemur',
  'venv' => '/venv',
  'uid' => nil,
  'gid' => nil,
  'version' => '3.4',
  'pip_version' => true,
  'setuptools_version' => true,
  'wheel_version' => true,
  'python_provider' => :system
}

# See documentation for configuration options at:
# http://lemur.readthedocs.io/en/latest/administration.html#configuration
default['lemur']['lemur'] = {
  'repository' => 'https://github.com/Netflix/lemur',
  'revision' => 'refs/heads/master',
  'app' => '/app',
  'config_template_cookbook' => 'lemur',
  'config' => {
    'threads_per_page' => '8',
    'admins' => ['lemur'],
    'lemur_restricted_domains' => [],
    'lemur_email' => 'lemur@example.com',
    'lemur_email_sender' => 'SMTP',
    'lemur_default_expiration_intervals' => [30, 15, 2],
    'lemur_security_team_email' => ['lemur-security@example.com'],
    'lemur_default_country' => 'country',
    'lemur_default_state' => 'state',
    'lemur_default_location' => 'location',
    'lemur_default_organization' => 'organization',
    'lemur_default_organizational_unit' => 'organizational_unit',
    'lemur_default_issuer_plugin' => 'cryptography-issuer',
    'lemur_allow_weekend_expiration' => 'True',
    'active_providers' => [],
    'log_level' => 'DEBUG',
    'log_file' => 'lemur.log',
    'debug' => 'True',
    'cors' => 'False',
    'sqlalchemy_database_uri' => {
      'scheme' => 'postgresql://',
      'user' => 'lemur',
      'host' => 'localhost',
      'port' => '5432',
      'database' => 'lemur'
    },
    'misc_options' => {}
  }
}

default['lemur']['nginx'] = {
  'siteconfig_template' => 'nginx-site.conf.erb',
  'siteconfig_template_cookbook' => 'lemur'
}
