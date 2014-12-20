chosen
======

This simple gem allows you to add a chosen field into your views.

### Getting Started

Rails 4.0.4:

Add into your Gemfile:

    gem 'chosen'

The necessary files are already in your asset pipeline. Just add below lines in your layout

    <%= javascript_include_tag 'chosen.jquery' %>
    <%= stylesheet_link_tag 'chosen' %>

### Usage

Add this to your view.

	<%= chosen_tag :name, options_for_select(Country.all.map{|c|[c.name,c.id]})%>


You can also use it with the form helper like:

    <% form_for(@user) do |f| %>
        <%= f.chosen_field :name, options_for_select(Country.all.map{|c|[c.name,c.id]})%>
        <%= f.submit 'Create' %>
    <% end %>

Where "name" is your object name. Chosen automatically sets the default field text ("Choose a country...") by reading the select element's data-placeholder value. If no data-placeholder value is present, it will default to "Select an Option" or "Select Some Options" depending on whether the select is single or multiple.
#### If you want to make use of data-placeholder in rails just insert a blank option value at index 0.

You can also pass options as it would be a normal select_field, plus all the chosen options available 

### Other Available options

    :disabled
    :no_results_text
    :width
    :allow_single_deselect
    :max_selected_options
    :disable_search_threshold

you can also use multiple: true as used in normal tag for multiselect.

You can find detail here:

https://github.com/harvesthq/chosen
