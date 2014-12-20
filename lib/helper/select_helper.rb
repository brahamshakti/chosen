require 'helper/form_helper'

module Chosen
  module SelectHelper
    include Chosen::FormHelper
    
    def chosen_tag(method, choices, options)
     chosen_field(method, choices, options ||= {})
   end
  end
end