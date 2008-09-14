require "rubygems"

# Add the local gems dir if found within the app root; any dependencies loaded
# hereafter will try to load from the local gems before loading system gems.
if (local_gem_dir = File.join(File.dirname(__FILE__), '..', 'gems')) && $BUNDLE.nil?
  $BUNDLE = true; Gem.clear_paths; Gem.path.unshift(local_gem_dir)
end

require "merb-core"
require "spec" # Satisfies Autotest and anyone else not using the Rake tasks

# this loads all plugins required in your init file so don't add them
# here again, Merb will do it for you
Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

module Merb
  module Test
    module ViewHelper
      def form_create_post_present?(body)
        body.should match_selector("form[@action='/entries/create]'")
        body.should match_selector("form[@action='/entries/create'] input[@name='entry[author]']")
        body.should match_selector("form[@action='/entries/create'] input[@name='entry[email]']")
        body.should match_selector("form[@action='/entries/create'] textarea[@name='entry[text]']")
        body.should match_selector("form[@action='/entries/create'] input[@type='submit' name='preview_button']")
        body.should match_selector("form[@action='/entries/create'] input[@type='submit' name='post_button']")
      end
    end
  end
end

module SessionHelper
  attr_accessor :session
end

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
end
