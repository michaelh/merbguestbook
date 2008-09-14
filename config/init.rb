$KCODE = 'UTF8'

#
# ==== Structure of Merb initializer
#
# 1. Load paths.
# 2. Dependencies configuration.
# 3. Libraries (ORM, testing tool, etc) you use.
# 4. Application-specific configuration.

#
# ==== Set up load paths
#

# Add the app's "gems" directory to the gem load path.
# Note that the gems directory must mirror the structure RubyGems uses for
# directories under which gems are kept.
#
# To conveniently set it up, use gem install -i <merb_app_root/gems>
# when installing gems. This will set up the structure under /gems
# automagically.
#
# An example:
#
# You want to bundle ActiveRecord and ActiveSupport with your Merb
# application to be deployment environment independent. To do so,
# install gems into merb_app_root/gems directory like this:
#
# gem install -i merb_app_root/gems activesupport-post-2.0.2.gem activerecord-post-2.0.2.gem
#
# Since RubyGems will search merb_app_root/gems for dependencies, order
# in the statement above is important: we need to install ActiveSupport which
# ActiveRecord depends on first.
#
# Remember that bundling of dependencies as gems with your application
# makes it independent of the environment it runs in and is a very
# good, encouraged practice to follow.

# If you want modules and classes from libraries organized like
# merbapp/lib/magicwand/lib/magicwand.rb to autoload,
# uncomment this.
# Merb.push_path(:lib, Merb.root / "lib") # uses **/*.rb as path glob.

# ==== Dependencies

dependency "merb-more"
dependency "merb_helpers"
dependency "merb_global"
dependency "gravtastic"
dependency "merb_paginate"
dependency "merb-fixtures"
dependency "merb_recaptcha"

# You can also add in dependencies after your application loads.
Merb::BootLoader.after_app_loads do
  # For example, the magic_admin gem uses the app's model classes. This requires that the models be 
  # loaded already. So, we can put the magic_admin dependency here:
  # dependency "magic_admin"
end

#
# ==== Set up your ORM of choice
#

use_orm :activerecord

#
# ==== Pick what you test with
#

use_test :rspec


#
# ==== Choose which template engine to use by default
#

use_template_engine :haml
# ==== Set up your basic configuration
#

# IMPORTANT:
#
# early on Merb boot init file is not yet loaded.
# Thus setting PORT, PID FILE and ADAPTER using init file does not
# make sense and only can lead to confusion because default settings
# will be used instead.
#
# Please use command line options for them.
# See http://wiki.merbivore.com/pages/merb-core-boot-process
# if you want to know more.
Merb::Config.use do |c|

  # Sets up a custom session id key which is used for the session persistence
  # cookie name.  If not specified, defaults to '_session_id'.
  # c[:session_id_key] = '_session_id'

  c[:session_secret_key]  = '805e03e78ec3fbade272615fb6a2af2c7cf4671f'
  c[:session_store] = 'cookie'

  c[:haml] = { :attr_wrapper => '"' } 
end

Merb::Plugins.config[:merb_global] = {
  :message_provider => 'yaml'
}

# We use merb-fixtures currently only for testing
Merb::Plugins.config[:fixtures] = {
  :autoload => false
}

# ==== Tune your inflector

# To fine tune your inflector use the word, singular_word and plural_word
# methods of English::Inflect module metaclass.
#
# Here we define erratum/errata exception case:
#
# English::Inflect.word "erratum", "errata"
#
# In case singular and plural forms are the same omit
# second argument on call:
#
# English::Inflect.word 'information'
#
# You can also define general, singularization and pluralization
# rules:
#
# Once the following rule is defined:
# English::Inflect.rule 'y', 'ies'
#
# You can see the following results:
# irb> "fly".plural
# => flies
# irb> "cry".plural
# => cries
#
# Example for singularization rule:
#
# English::Inflect.singular_rule 'o', 'oes'
#
# Works like this:
# irb> "heroes".singular
# => hero
#
# Example of pluralization rule:
# English::Inflect.singular_rule 'fe', 'ves'
#
# And the result is:
# irb> "wife".plural
# => wives
