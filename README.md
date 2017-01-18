# lemur Cookbook

This cookbook builds a server running Netflix's lemur certificate authority
management interface. More information, documentation, etc about Lemur can be
found in the [Netflix GitHub rep for Lemur](https://github.com/Netflix/lemur).

## Requirements

### Platforms

* Ubuntu 14.04+

Probably works with other reasonably recent Debian derivatives.

### Releases

# tag 0.1.0

This release works with deploying lemur 0.4.0 in a Python 2.7 environment.
After 0.4.0, lemur will require Python 3.4.

# branch python3

I'm working on supporting newer releases of lemur on Python 3.4 in this branch.
It hasn't been released yet, so this branch currently deploys from HEAD in the
lemur codebase.


### Cookbooks

* nginx cookbook to setup web UI 
* poise-python to setup Python virtualenv
* apt cookbook to configure repos
* postgresql cookbook to setup postgres
* database cookbook to configure postgres
* cron cookbook to setup cron jobs

The exact versions of these aren't too restricted, but what's in the metadata.rb
works for me.

## Recipes

### default

This recipe builds an all-in-one lemur server according to the 
[Quickstart](http://lemur.readthedocs.io/en/latest/quickstart/index.html)
documentation.

## Attributes

### Feature Flags

The setup and configuration of the major auxiliary components (nginx and
postgres) can be disabled if you would like to configure them on different
servers or with different recipes. These both default to true.

* `["lemur"]["feature_flags"]["postgres"]` - install/configure PostgreSQL
* `["lemur"]["feature_flags"]["nginx"]` - install/configure nginx

### Package Dependencies

These packages all must be installed as pre-requisites for Lemur. By default,
they will automatically upgrade to the latest version available (leave values
at `nil`), but if you specify a version, that will lock them to that version.

```json
{
  "lemur"
    "dependencies": {
      "nodejs-legacy": null,
      "python-pip": null,
      "python-dev": null,
      "libpq-dev": null,
      "build-essential": null,
      "libssl-dev": null,
      "libffi-dev": null,
      "nginx": null,
      "git": null,
      "supervisor": null,
      "npm": null,
      "postgresql": null
    }
  }
}
```

### Virtualenv Options

The default behavior is to setup a user and a group called `lemur`, create a
home directory for the user, install the app into `~lemur/app`, and install the
virtual env into `~lemur/venv`. The Python version is 2.7, which is the intended
version for the most recent release of Lemur, but there is currently work
underway in the latest code commits that will require Python3. *This is a major
but known problem with getting a useful out-of-the-box experience with Lemur.*

The options for configuring the virtualenv can all be found in:
* `["lemur"]["virtualenv"]` - options to configure the virtual environment 

### Lemur Options

These options control the Lemur installation itself.

* `["lemur"]["lemur"]["repository"]` - code source for Lemur
* `["lemur"]["lemur"]["revision"]` - revision of repo to sync
* `["lemur"]["lemur"]["app"]` - path to application inside home directory
* `["lemur"]["lemur"]["config_template_cookbook"]` - If you want to use your own
template for the lemur.conf.py configuration file, this can be overwritten to
your cookbook.
* `["lemur"]["lemur"]["config"]` - Mash of common options specified in the
default lemur.conf.py configuration file. *You probably want to set these
attributes in your installation.*
* `["lemur"]["lemur"]["config"]["sqlalchemy_database_uri"]` - Mash of
elements of a sqlalchemy database URI. *You want to set these if you are
configuring your own PostgreSQL database.*
* `["lemur"]["lemur"]["misc_options"]` - Mash of additional arbitrary options
you'd like to add to the lemur.conf.py. Anything you see at
<http://lemur.readthedocs.io/en/latest/administration.html#configuration> is
fair game here.

### Nginx Options

These options allow for replacing the simple nginx site template with one more
suited to your installation.

* `["lemur"]["nginx"]["siteconfig_template"]` - Option for nginx site template
name
* `["lemur"]["nginx"]["siteconfig_template_cookbook"]` - Option for nginx site
template cookbook

## Usage

1. Put `recipe[lemur::default]` in your run list.
2. Visit http://servername to see the Lemur web UI.

- or -

1. Build the cookbook with `chef exec kitchen converge`.
2. Visit http://localhost:;8080 to see the Lemur web UI.

### Secrets

In initial configuration, this cookbook will create a `lemur` user with the
password `lemur` that has full admin privileges inside the lemur application.
Please assume you should change that once you configure your alternative auth
system and/or users.

There are also 4 files created in the `/home/lemur/.lemur` directory for
secrets used in the app itself.

* `flask_secret_key`
* `lemur_encryption_keys`
* `lemur_token_secret`
* `postgres_password`

Those files are protected so only the `lemur` user can access them. The cookbook
will not overwrite them if they already exist, so if you want to use different
values for these variables, just make sure you write whatever secret data you
want in those files before this recipe runs.

I elected to do it this way to ensure the out-of-the-box experience _just
worked_ while still allowing folks who don't trust their random number
generators to specify their own values easily enough.

## Testing

These should all exit 0 for success.

* `chef exec foodcritic -X test .` Chef linter
* `chef exec rubocop` - Ruby linter
* `chef exec rspec -f d` - RSpec unit tests
* `chef exec kitchen verify` -  Functional testing with inspec  

## License and Authors

**Author:** Neil Schelly ([neil@neilschelly.com](mailto:neil@neilschelly.com))

**Copyright:** 2016, Dynamic Network Services, Inc.


```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
