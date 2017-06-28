### MONKEY PATCH WARNING
### Need to limit new_relic agents due to their ridiculous pricing model
require 'new_relic/control'

WEBSERVERS = %w(armadillo)

module NewRelic
  class Railtie < Rails::Railtie
    if WEBSERVERS.include?(`hostname`.chomp)
      initializer "newrelic_rpm.start_plugin" do |app|
        NewRelic::Control.instance.init_plugin(:config => app.config)
      end
    end
  end
end
