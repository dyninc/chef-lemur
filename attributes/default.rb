# Default attributes

# These all default to true, but can be disabled if you want to configure
# any of the pieces yourself, outside this cookbook.
default["lemur"]["feature_flags"] = {
  "postgres" => true,
  "nginx" => true
}

# Dependencies and versions
# nil versions will automatically upgrade
default["lemur"]["dependencies"] = {
  "nodejs-legacy" => nil,
  "python-pip" => nil,
  "python-dev" => nil,
  "libpq-dev" => nil,
  "build-essential" => nil,
  "libssl-dev" => nil,
  "libffi-dev" => nil,
  "nginx" => nil,
  "git" => nil,
  "supervisor" => nil,
  "npm" => nil,
  "postgresql" => nil
}

# Setup Pytnon virtualenv
default["lemur"]["virtualenv"] = {
  "user" => "lemur",
  "group" => "lemur",
  "home" => "/home/lemur",
  "venv" => "/venv",
  "uid" => nil,
  "gid" => nil,
  "version" => "2.7",
  "pip_version" => true,
  "setuptools_version" => true,
  "wheel_version" => true,
  "python_provider" => :system
}

default["lemur"]["lemur"] = {
  "repository" => "https://github.com/neilschelly/lemur",
  "revision" => "HEAD",
  "app" => "/app",
  "config_template_cookbook" => "lemur",
  "config" => {
    "admins" => [''],
    "lemur_restricted_domains" => [],
    "lemur_email" => "lemur@example.com",
    "lemur_security_team_email" => ["lemur-security@example.com"],
    "lemur_default_country" => "country",
    "lemur_default_state" => "state",
    "lemur_default_location" => "location",
    "lemur_default_organization" => "organization",
    "lemur_default_organizational_unit" => "organizational_unit",
    "active_providers" => [],
    "log_level" => "DEBUG",
    "log_file" => "lemur.log",
    "sqlalchemy_database_uri" => {
      "scheme" => "postgresql://",
      "user" => "lemur",
      "host" => "localhost",
      "port" => "5432",
      "database" => "lemur"
    }
  }
}

default["lemur"]["nginx"] = {
  "siteconfig_template" => "site.conf.erb",
  "siteconfig_template_cookbook" => "lemur",

}