# frozen_string_literal: true

module Webmcp
  class FormBuilder < ActionView::Helpers::FormBuilder
    WEBMCP_FIELD_METHODS = %i[
      text_field email_field password_field number_field
      date_field datetime_field time_field url_field
      telephone_field search_field text_area color_field range_field
    ].freeze

    WEBMCP_FIELD_METHODS.each do |method_name|
      define_method(method_name) do |attribute, options = {}|
        options = inject_webmcp_param_attrs(options)
        super(attribute, options)
      end
    end

    def hidden_field(method, options = {})
      options = inject_webmcp_param_attrs(options)
      super(method, options)
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      webmcp = html_options.delete(:webmcp) || options.delete(:webmcp)
      if webmcp
        html_options[:toolparamdescription] = webmcp[:param_description] if webmcp[:param_description]
        html_options[:toolparamtitle] = webmcp[:param_title] if webmcp[:param_title]
      end
      super(method, choices, options, html_options, &block)
    end

    private

    def inject_webmcp_param_attrs(options)
      webmcp = options.delete(:webmcp)
      return options unless webmcp

      options[:toolparamdescription] = webmcp[:param_description] if webmcp[:param_description]
      options[:toolparamtitle] = webmcp[:param_title] if webmcp[:param_title]
      options
    end
  end
end
