require "chosen/version"
require "helper/select_helper"
require "helper/form_helper"

module Chosen
  class Engine < Rails::Engine
    initializer 'chosen.app.assets.precompile' do |app|
      %w(stylesheets javascripts fonts images).each do |sub|
        app.config.assets.paths << root.join('app/assets', sub)
      end
    end
  end
  class Railtie < Rails::Railtie
    initializer "Chosen" do
      ActionController::Base.helper(Chosen::SelectHelper)
      ActionView::Helpers::FormHelper.send(:include, Chosen::FormHelper)
      ActionView::Base.send(:include, Chosen::SelectHelper)
      ActionView::Helpers::FormBuilder.send(:include,Chosen::FormBuilder)
    end
  end
end
