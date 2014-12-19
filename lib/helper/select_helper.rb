require 'helper/form_helper'

module Chosen
  module SelectHelper

    include Chosen::FormHelper

    # Helper method that creates a chosen or select field
    def chosen(method, choices, options = {})
      chosen_field(method, choices, options, self)
    end

  end
end