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

You can also use it with the form helper like:

    <% form_for(@user) do |f| %>
        <%= f.chosen_field :name, options_for_select(Country.all.map{|c|[c.name,c.id]}), :class => 'chosen-single' %>
        <%= f.submit 'Create' %>
    <% end %>

Where "name" is your object name.

You can also pass options as it would be a normal select_field.

### Other Available options

    :disabled
    :no_results_text
    :width
    :allow_single_deselect
    :max_selected_options
    :disable_search_threshold

you can also use multiple: multiple as used in normal tag.

You can find detail here:

https://github.com/harvesthq/chosen
