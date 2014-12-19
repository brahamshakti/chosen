module Chosen
  module FormHelper
    include ActionView::Helpers::JavaScriptHelper

    # Mehtod that generates chosen select field inside a form
    def chosen_field(method, choices, options = {})
      object_class = options[:object].class.to_s.underscore
      select_tag =  Chosen::InstanceTag.new(object_class, method)
      options.delete(:object)
      #### ci_options = Chosen Filed Option ####
      #### sf_options = Select Field Option ####
      ci_options, sf_options =  select_tag.split_options(options)
      html = select_tag.select_content_tag(choices, ci_options, sf_options)
      html += javascript_tag("jQuery(document).ready(function(){jQuery('##{select_tag.get_name_and_id(sf_options.stringify_keys)["id"]}').chosen(#{ci_options.to_json})});")
      html.html_safe
    end

  end

  class String
    def underscore
      self.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
    end
  end

end

module Chosen::FormBuilder
  def chosen_field(method,choices, options = {})
    @template.chosen_field(method, choices, objectify_options(options))
  end
end

class Chosen::InstanceTag
  include ActionView::Helpers::TagHelper
  attr_reader :object, :method_name, :object_name

  def initialize(object_name, method_name)
    @object_name, @method_name = object_name.to_s.dup, method_name.to_s.dup
    @object_name.sub!(/\[\]$/,"") || @object_name.sub!(/\[\]\]$/,"]")
  end

  def split_options(options)
    sf_options = options.slice!(*available_chosen_options)
    return options, sf_options
  end

  def select_content_tag(option_tags, options, html_options)
    html_options = html_options.stringify_keys
    add_default_name_and_id(html_options)
    select = content_tag("select", add_options(option_tags, options, value(object)), html_options)
    if html_options["multiple"]
      tag("input", :disabled => html_options["disabled"], :name => html_options["name"], :type => "hidden", :value => "") + select
    else
      select
    end
  end
  def add_options(option_tags, options, value = nil)
    if options[:include_blank]
      option_tags = content_tag_string('option', options[:include_blank].kind_of?(String) ? options[:include_blank] : nil, :value => '') + "\n" + option_tags
    end
    if value.blank? && options[:prompt]
      prompt = options[:prompt].kind_of?(String) ? options[:prompt] : I18n.translate('helpers.select.prompt', :default => 'Please select')
      option_tags = content_tag_string('option', prompt, :value => '') + "\n" + option_tags
    end
    option_tags
  end

  def add_default_name_and_id(options)
    if options.has_key?("index")
      options["name"] ||= tag_name_with_index(options["index"])
      options["id"] = options.fetch("id"){ tag_id_with_index(options["index"]) }
      options.delete("index")
    else
      options["name"] ||= tag_name + (options['multiple'] ? '[]' : '')
      options["id"] = options.fetch("id"){ tag_id }
    end
    options["id"] = [options.delete('namespace'), options["id"]].compact.join("_").presence
  end

  def tag_name
    "#{@object_name}[#{sanitized_method_name}]"
  end

  def tag_name_with_index(index)
    "#{@object_name}[#{index}][#{sanitized_method_name}]"
  end

  def tag_id
    "#{sanitized_object_name}_#{sanitized_method_name}"
  end

  def tag_id_with_index(index)
    "#{sanitized_object_name}_#{index}_#{sanitized_method_name}"
  end

  def sanitized_object_name
    @sanitized_object_name ||= @object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
  end

  def sanitized_method_name
    @sanitized_method_name ||= @method_name.sub(/\?$/,"")
  end

  def value(object)
    self.class.value(object, @method_name)
  end

  class << self
    def value(object, method_name)
      object.send method_name if object
    end
  end

  def get_name_and_id(options = {})
    add_default_name_and_id(options)
    options
  end

  def available_chosen_options
    [:disabled,:no_results_text,:width,:allow_single_deselect,:max_selected_options,:disable_search_threshold]
  end


end